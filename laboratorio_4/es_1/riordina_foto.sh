#!/bin/sh

# 1. Controllo del numero di argomenti (devono essere esattamente 2)
if test $# -ne 2; then
    echo "Errore: Numero di argomenti errato."
    echo "Uso: $0 dir_sorgente dir_destinazione"
    exit 1
fi


# 2. Controllo che i percorsi siano relativi (non devono iniziare con '/')
case "$1" in
    /*) echo "Errore: '$1' deve essere un percorso relativo."
        exit 2 ;;
esac

case "$2" in
    /*) echo "Errore: '$2' deve essere un percorso relativo."
        exit 3 ;;
esac


# 3. Controllo esistenza e tipo delle directory
if test ! -d "$1"; then
    echo "Errore: '$1' non esiste o non e' una directory."
    exit 4
fi

if test ! -d "$2"; then
    echo "Errore: '$2' non esiste o non e' una directory."
    exit 5
fi


# 4. Conversione dei percorsi relativi in assoluti
case "$1" in 
    /*) DIR_SORG="$1" ;;
    *) DIR_SORG="`pwd`/$1" ;;
esac

case "$2" in 
    /*) DIR_DEST="$2" ;;
    *) DIR_DEST="`pwd`/$2" ;;
esac


# 5. Esportazione del PATH per permettere la chiamata a ricorsivo.sh
PATH=`pwd`:$PATH
export PATH


# 6. Invocazione dello script ricorsivo
ricorsivo.sh "$DIR_SORG" "$DIR_DEST"

# 7. Conteggio dei file spostati direttamente in dir_destinazione
CONTEGGIO=0
for f in "$DIR_DEST"/*; do
    if test -f "$f"; then
        CONTEGGIO=`expr $CONTEGGIO + 1`
    fi
done

echo "Operazione completata."
echo "Numero di file spostati nella directory $2: $CONTEGGIO"

