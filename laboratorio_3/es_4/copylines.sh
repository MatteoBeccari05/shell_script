#!/bin/sh

# 1. Controllo numero minimo di argomenti (almeno 3: dir_assoluto, stringa, nomefile1)
if test $# -lt 3; then
    echo "Errore: numero di argomenti insufficiente." >&2
    echo "Uso: $0 <nome_dir_assoluto> <stringa> <nomefile1> [nomefile2 ...]" >&2
    exit 1
fi

# 2. Controllo che il primo argomento sia un percorso assoluto
case "$1" in
    /*) ;;
    *)
        echo "Errore: '$1' non è un percorso assoluto (deve iniziare con /)." >&2
        exit 2
        ;;
esac

# Controllo che il primo argomento sia una directory esistente
if test ! -d "$1"; then
    echo "Errore: '$1' non è una directory esistente." >&2
    exit 3
fi

dir_assoluto="$1"
stringa="$2"

# Rimuoviamo i primi due argomenti ($1 e $2) in modo che $@ contenga solo i nomi di file
shift 2

# 3. Controllo dei restanti argomenti: devono contenere SOLO caratteri alfabetici minuscoli
for file_param in "$@"; do
    expr "$file_param" : '^[a-z][a-z]*$' > /dev/null
    if test $? -ne 0; then
        echo "Errore: '$file_param' deve contenere solo lettere minuscole (nessuna cifra o carattere speciale)." >&2
        exit 4
    fi
done

# Esportiamo la directory corrente in PATH in modo che la chiamata ricorsiva trovi copylines_rec.sh
SCRIPT_DIR=`pwd`
PATH=$PATH:$SCRIPT_DIR
export PATH

# Definizione e creazione file temporanei per contatore e linee trovate
TMP_MOVED=/tmp/copylines_moved_$$
TMP_LINES=/tmp/copylines_lines_$$
export TMP_MOVED TMP_LINES

# 4. Ciclo principale di ricerca ed eventuale sospensione
while test 1 -eq 1; do
    # Inizializziamo/svuotiamo i file temporanei
    > "$TMP_MOVED"
    > "$TMP_LINES"

    # Invocazione dello script ricorsivo
    copylines_rec.sh "$dir_assoluto" "$stringa" "$@"

    # Conteggio del numero globale di file spostati
    if test -f "$TMP_MOVED"; then
        num_spostati=`wc -l < "$TMP_MOVED" | tr -d ' '`
    else
        num_spostati=0
    fi

    # Verifichiamo se sono stati spostati dei file
    if test "$num_spostati" -gt 0; then
        echo "=================================================="
        echo "Numero globale di file spostati in /tmp: $num_spostati"
        echo "--------------------------------------------------"
        echo "Linee che contenevano la stringa '$stringa':"
        cat "$TMP_LINES"
        echo "=================================================="

        # Pulizia file temporanei ed uscita
        rm -f "$TMP_MOVED" "$TMP_LINES"
        exit 0
    else
        echo "Nessun file spostato. Sospensione per 1 ora (3600 secondi)..."
        sleep 3600
    fi
done