#!/bin/bash

# 1. Gestione degli argomenti passati da riga di comando
case $# in
    1) 
        d=$(pwd)
        f=$1
        ;;
    2) 
        d=$1
        f=$2
        ;;
    *) 
        echo "Errore. Usa: $0 [direttorio] file" >&2
        exit 2 
        ;;
esac

# 2. Configurazione del PATH per permettere l'esecuzione e la ricorsione
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PATH="$PATH:$SCRIPT_DIR"
export PATH

# 3. Avvia lo script di ricorsione passando directory e file
# (Assicurati che il file 'ricorsione' si trovi nella stessa cartella e sia eseguibile)
if [ -x "$SCRIPT_DIR/ricorsione.sh" ]; then
    "$SCRIPT_DIR/ricorsione.sh" "$d" "$f"
else
    echo "Errore: script 'ricorsione' non trovato o non eseguibile nella cartella." >&2
    exit 1
fi

#FUNZIONAMENTO
#./cercadir.sh /home/matteo/Scrivania/shell_script/ultimi_esempi_slide/ file1.txt
# primo argomento: cartella percorso
# secondo argomento: file da cercare
# output: Il file file1.txt è in /home/matteo/Scrivania/shell_script/ultimi_esempi_slide/