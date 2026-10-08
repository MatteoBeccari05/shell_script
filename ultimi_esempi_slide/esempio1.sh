#!/bin/bash

# Controllo se sono stati forniti argomenti
if [ $# -eq 0 ]; then
    echo "Uso: $0 file1 [file2 ...]"
    exit 1
fi

# Ciclo su tutti gli argomenti mantenendo gli spazi nei nomi dei file
for i in "$@"; do
    if [ -f "$i" ]; then
        echo "=== Contenuto di: $i ==="
        cat "$i"
        echo ""
    else
        echo "Errore: '$i' non è un file regolare o non esiste."
    fi
done

#argomenti: serve almeno un file in ingresso