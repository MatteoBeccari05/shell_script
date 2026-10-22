#!/bin/sh

# Verifica che i parametri siano esattamente 3 (stringa, dir, num)
if test $# -ne 3
then
    echo "Errore: numero di parametri errato."
    echo "Uso: $0 stringa dir num"
    exit 1
fi

stringa=$1
dir=$2
num=$3

# Controllo che 'dir' sia un percorso assoluto
case "$dir" in
    /*) ;;
    *)
        echo "Errore: '$dir' non e' un percorso assoluto."
        exit 2
        ;;
esac

# Controllo che 'dir' sia una directory esistente
if test ! -d "$dir"
then
    echo "Errore: '$dir' non e' una directory valida o esistente."
    exit 3
fi

# Controllo che 'num' sia un intero positivo o zero
case "$num" in
    ''|*[!0-9]*)
        echo "Errore: '$num' non e' un numero intero valido."
        exit 4
        ;;
esac

# AGGIUNTA DELLA DIRECTORY CORRENTE ALLA VARIABILE $PATH
PATH=$PATH:`pwd`
export PATH

# CREAZIONE DEI FILE TEMPORANEI CON PERCORSO ASSOLUTO
max_counter="`pwd`/max_counter.tmp"
max_dirname="`pwd`/max_dirname.tmp"

# Inizializziamo i file temporanei vuoti
> "$max_counter"
> "$max_dirname"

# Chiamata a cercaStringa.sh
cercaStringa.sh "$stringa" "$dir" "$num" "$max_counter" "$max_dirname"

if test -s "$max_dirname"
then    
    risultato=`cat "$max_dirname"`
    max_file=`wc -l < "$max_counter"`
    echo "La directory con il maggior numero di file idonei ($max_file file) e':"
    echo "$risultato"
else
    echo "Nessuna directory trovata"
fi

# Rimozione dei file temporanei globali
rm -f "$max_counter" "$max_dirname"

exit 0