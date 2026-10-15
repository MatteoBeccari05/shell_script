#!/bin/sh

if test $# -lt 2
then    
    echo "Errore numero parametri"
    exit 1
fi

file=$1

if test ! -f "$file"
then
    echo "Il primo argomento deve essere un file"
    exit 2
fi

#rimuovo il primo argomento
shift


for i in "$@"
do
    count=`grep "$i" "$file" | wc -l`
    echo "Parametro: $i - Ricorrenze: $count"
done