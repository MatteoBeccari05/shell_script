#!/bin/bash

echo -n "Inserisci un giorno della settimana: "
read GIORNO

# Converte l'input in minuscolo
GIORNO=$(echo "$GIORNO" | tr '[:upper:]' '[:lower:]')

case "$GIORNO" in
    lunedì)
        echo "Inizio della settimana lavorativa."
        ;;
    martedì | mercoledì | giovedì | venerdì)
        echo "Giorno lavorativo."
        ;;
    sabato | domenica)
        echo "È il fine settimana!"
        ;;
    *)
        echo "Giorno non valido."
        ;;
esac