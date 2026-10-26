#!/bin/bash

# 1. Controllo sul numero di argomenti (deve essere esattamente 1)
if test $# -ne 1
then
    echo "Uso: $0 dir_assoluta"
    exit 1
fi

# 2. Controllo che il percorso sia assoluto (deve iniziare con '/')
case "$1" in
    /*) ;; # Percorso valido
    *)  echo "Errore: $1 non e' un percorso assoluto."
        exit 2 ;;
esac

# 3. Controllo che la directory esista e sia accessibile in lettura ed esecuzione
if test ! -d "$1" -o ! -r "$1" -o ! -x "$1"
then
    echo "Errore: $1 non e' una directory valida o non si hanno i permessi necessari."
    exit 3
fi

# 4. Aggiunta della directory corrente al PATH per permettere l'invocazione dello script ricorsivo
PATH=$PATH:.
export PATH

# 5. Definizione ed esportazione delle variabili per i file di output e temporanei
export FILE_ERRORI="$HOME/errori.txt"
export FILE_WARNING="$HOME/warning.txt"
export FILE_TMP="/tmp/trova_errori_count_$$"

# Inizializzazione/svuotamento dei file di output
> "$FILE_ERRORI"
> "$FILE_WARNING"
> "$FILE_TMP"

# 6. Invocazione dello script ricorsivo sulla directory di partenza
trova_errori_ric.sh "$1"

# 7. Elaborazione del file temporaneo per individuare la directory con il maggior numero di errori
MAX_ERR=0
DIR_MAX=""

if test -f "$FILE_TMP" -a -s "$FILE_TMP"
then
    while read -r count dir_path
    do
        if test "$count" -gt "$MAX_ERR"
        then
            MAX_ERR=$count
            DIR_MAX="$dir_path"
        fi
    done < "$FILE_TMP"
fi

# 8. Stampa finale del risultato a video
if test "$MAX_ERR" -gt 0
then
    echo "La directory che contiene il maggior numero di errori e': $DIR_MAX (con $MAX_ERR errori)"
else
    echo "Nessun messaggio di errore trovato nei file di log analizzati."
fi

# Rimozione del file temporaneo
rm -f "$FILE_TMP"