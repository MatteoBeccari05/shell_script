#!/bin/sh

# Salvataggio dei parametri ricevuti
num=$1
dirSorgente=$2
dirDestinazione=$3
counterFile=$4

# Isoliamo le estensioni (da $5 in poi)
shift 4


# ENTRATA NELLA DIRECTORY PASSATA COME PARAMETRO
cd "$dirSorgente" || exit 1

# RICERCA FILE E SPOSTAMENTO
# Primo ciclo: scorre una per una tutte le estensioni passate (es. .txt, .c, .h)
for ext in "$@"
do
    # Secondo ciclo: cerca tutti i file nella directory corrente che terminano con l'estensione $ext.
    # Esempio: se $ext e' ".txt", *$ext diventa *.txt
    for f in *$ext
    do
        # TRUCCO BOURNE SHELL: Se non esiste alcun file .txt, la shell NON lascia la lista vuota,
        # ma usa la stringa letterale "*.txt". 
        # 'test -f "$f"' verifica che "$f" sia VERAMENTE un file regolare esistente su disco.
        if test -f "$f"
        then
            # Controlla se l'UTENTE attuale ha il permesso di LETTURA (-r) sul file
            if test -r "$f"
            then
                # Calcola il numero di righe del file.
                # NOTA IMPORTANTE: Si usa la ridirezione '< "$f"' anziche' 'wc -l "$f"'
                # per fare in modo che 'wc' stampi SOLO il numero di righe e NON anche il nome del file.
                nrighe=`wc -l < "$f"`

                # Confronta se il numero di righe del file e' STRETTAMENTE MAGGIORE (-gt) di $num
                if test "$nrighe" -gt "$num"
                then
                    # 1. Scrive una riga nel file temporaneo counter.tmp salvando il percorso completo.
                    # 'pwd' restituisce la directory attuale, trattino '/', poi il nome del file.
                    echo "`pwd`/$f" >> "$counterFile"

                    # 2. Sposta il file nella directory di destinazione
                    mv "$f" "$dirDestinazione"
                fi
            fi
        fi
    done
done


# RICORSIONE SULLE SOTTODIRECTORY
# Ciclo che scorre OGNI elemento contenuto nella directory corrente
for d in *
do
    # Verifica se l'elemento 'd' e' una DIRECTORY (-d)
    if test -d "$d"
    then
        # CONTROLLO DI SICUREZZA:
        # Se la directory di destinazione si trova dentro la directory di sorgente,
        # dobbiamo evitare di entrarci per non creare un ciclo infinito di ricerca!
        if test "`pwd`/$d" != "$dirDestinazione"
        then
            # Nei sistemi Unix, per poter "entrare" in una directory con 'cd',
            # l'utente deve avere il permesso di ESECUZIONE (-x) sulla directory.
            if test -x "$d"
            then
                # CHIAMATA RICORSIVA:
                # Richiama lo script ricerca.sh passando come nuova dirSorgente il percorso di "$d".
                # Ricorda che "$@" ora contiene solo la lista delle estensioni.
                ricerca.sh "$num" "`pwd`/$d" "$dirDestinazione" "$counterFile" "$@"
            fi
        fi
    fi
done

exit 0

