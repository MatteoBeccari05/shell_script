#!/bin/sh

if test $# -ne 2
then 
    echo "Errore numero argomenti"
    exit 1
fi

reparto="$1"
shift
anno="$1"
shift

case "$reparto" in 
    *[!0-9A-Za-z]*) echo "reparto deve essere alfanumerica"
    exit 2 ;;
esac

case "$anno" in 
    /*) echo "Errore deve essere un path relativo"
        exit 3 ;;
    *) ;;
esac


case "$anno" in 
    *[!0-9A-Za-z]*) echo "anno deve essere alfanumerica"
    exit 4 ;;
esac

if test ! -d "$anno" -a -x "$anno"
then
   echo "Errore: anno non e' una directory"
   exit 5 
fi


PATH=`pwd`:$PATH
export PATH

RICOVERI="$HOME/ricoveri.txt"
> "$RICOVERI"
export RICOVERI

MAX_COUNT=/tmp/maxcount.txt
echo "0" > "$MAX_COUNT"
export MAX_COUNT

MAX_MONTH=/tmp/maxmonth.txt
> "$MAX_MONTH"
export MAX_MONTH

ospedale_ric.sh "$reparto" "$anno"


echo "Mese con il maggior numero di ricoveri:"
cat "$MAX_MONTH"

rm -f "$MAX_COUNT" "$MAX_MONTH"


