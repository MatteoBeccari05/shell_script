#!/bin/bash

NUMERO=100

# Esegue il blocco PRIMA di verificare la condizione
while true
do
    echo "Questo messaggio appare almeno una volta! (Numero: $NUMERO)"
    
    # Condizione di uscita controllata alla FINE del ciclo
    if [ $NUMERO -ge 100 ]; then
        break
    fi
done