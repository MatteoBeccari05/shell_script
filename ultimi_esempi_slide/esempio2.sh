#!/bin/bash

# Controllo presenza argomenti
if [ $# -eq 0 ]; then
    echo "Uso: $0 file1 [file2 ...]" >&2
    exit 1
fi

# Ciclo su tutti gli argomenti forniti ($@ gestisce correttamente gli spazi)
for i in "$@"; do
    # Verifica che l'elemento sia un file esistente
    if [ -f "$i" ]; then
        # 1. Invia il prompt direttamente al terminale dell'utente
        echo -n "$i ? " > /dev/tty

        # 2. Legge la risposta direttamente dal tastierino del terminale
        read -r answer < /dev/tty

        # 3. Valuta la risposta dell'utente
        case "$answer" in
            y* | Y* | s* | S* )
                echo "=== $i ==="
                cat "$i"
                ;;
        esac
    else
        echo "Avviso: '$i' non è un file valido." >&2
    fi
done

#esempio di utilizzo: 
# ./esempio2.sh file1.txt file2.txt > archivio.txt
# file1.txt ? no
# file2.txt ? sì