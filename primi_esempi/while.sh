#!/bin/bash

CONTATORE=1

# Controlla la condizione PRIMA di ogni giro
while [ $CONTATORE -le 3 ]
do
    echo "Conteggio while: $CONTATORE"
    CONTATORE=$((CONTATORE + 1))
done