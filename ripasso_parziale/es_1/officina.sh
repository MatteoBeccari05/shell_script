#!/bin/sh

# Verifico che ci siano esattamente 2 argomenti
if test $# -ne 2
then 
    echo "Errore: numero parametri errato"
    exit 1
fi

categoria="$1"
shift
anno="$1"
shift

# Verifica che categoria sia una stringa alfanumerica
case "$categoria" in
    *[!0-9A-Za-z]*) 
        echo "Errore: categoria non alfanumerica"
        exit 2 ;;
esac

# Verifica che anno sia un percorso assoluto
case "$anno" in 
    /*) ;;
    *) 
        echo "Errore: anno non e' un percorso assoluto"
        exit 3 ;;
esac

# Verifica che anno sia una directory esistente
if test ! -d "$anno"
then 
    echo "Errore: anno non e' una directory"
    exit 4
fi

# Verifica che anno sia attraversabile
if test ! -x "$anno"
then
    echo "Errore: directory non attraversabile"
    exit 5
fi

# Aggiungo la directory corrente al PATH per consentire l'invocazione di officina_ric.sh
PATH=`pwd`:$PATH
export PATH

RIEPILOGO="$HOME/riepilogo.log"
if test ! -f "$RIEPILOGO"
then 
    touch "$RIEPILOGO"
fi
export RIEPILOGO

MAX_COUNT=/tmp/maxcount.txt
echo "0" > "$MAX_COUNT"
export MAX_COUNT

MAX_CAT=/tmp/maxcat.txt
> "$MAX_CAT"
export MAX_CAT

# Invocazione dello script ricorsivo
officina_ric.sh "$categoria" "$anno"

# Stampa a video del risultato finale
echo "Categoria con il maggior numero di interventi in un singolo mese:"
cat "$MAX_CAT"

# Pulizia dei file temporanei
rm -f "$MAX_COUNT" "$MAX_CAT"