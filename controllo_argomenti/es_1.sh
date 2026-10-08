#!/bin/bash

# Controllo: verifica che siano stati passati almeno 4 argomenti
if [ "$#" -lt 4 ]; then
    echo "Errore: sono necessari almeno 4 argomenti. Usa: $0 arg1 arg2 arg3 arg4 [altri...]" >&2
    exit 1
fi

# Esempio di utilizzo degli argomenti ricevuti
echo "Numero totale di argomenti ricevuti: $#"
echo "Il primo argomento è: $1"
echo "Il secondo argomento è: $2"
echo "Il terzo argomento è: $3"
echo "Il quarto argomento è: $4"

# Se ci sono altri argomenti, puoi ciclarli con $@
shift 4
echo "Gli eventuali argomenti rimanenti sono: $@"