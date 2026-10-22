#!/bin/sh

if test $# -lt 4
then
    echo "Errore: numero di parametri insufficiente."
    echo "Uso: $0 num dirSorgente dirDestinazione ext1 [ext2 ... extN]"
    exit 1
fi

num=$1
dirSorgente=$2
dirDestinazione=$3

# Controllo che 'num' sia un numero intero non negativo
case "$num" in
    ''|*[!0-9]*)
        echo "Errore: '$num' non e' un numero intero valido."
        exit 2
        ;;
esac

# Controllo che 'dirSorgente' sia un percorso assoluto
case "$dirSorgente" in
    /*) ;;
    *)
        echo "Errore: '$dirSorgente' non e' un percorso assoluto."
        exit 3
        ;;
esac


# Controllo che 'dirSorgente' sia una directory esistente
if test ! -d "$dirSorgente"
then
    echo "Errore: '$dirSorgente' non e' una directory valida o esistente."
    exit 4
fi


# Controllo che 'dirDestinazione' sia un percorso assoluto
case "$dirDestinazione" in
    /*) ;;
    *)
        echo "Errore: '$dirDestinazione' non e' un percorso assoluto."
        exit 5
        ;;
esac


# Controllo che 'dirDestinazione' sia una directory esistente
if test ! -d "$dirDestinazione"
then
    echo "Errore: '$dirDestinazione' non e' una directory valida o esistente."
    exit 6
fi


# Controllo che tutte le estensioni inizino con il punto '.'
shift 3
for ext in "$@"
do
    case "$ext" in
        .*) ;;
        *)
            echo "Errore: l'estensione '$ext' deve iniziare con il carattere '.'."
            exit 7
            ;;
    esac
done


# AGGIUNTA DELLA DIRECTORY CORRENTE ALLA VARIABILE $PATH
PATH=$PATH:`pwd`
export PATH

# CREAZIONE DEL FILE TEMPORANEO counter.tmp
# Salviamo il percorso assoluto per consentire l'accesso continuo da ricerca.sh
counterFile="`pwd`/counter.tmp"
> "$counterFile"

# CHIAMATA A ricerca.sh
ricerca.sh "$num" "$dirSorgente" "$dirDestinazione" "$counterFile" "$@"


# STAMPA DEL RISULTATO E RIMOZIONE DEL COUNTER.TMP
if test -f "$counterFile"
then 
    totale=`wc -l < "$counterFile"`
    echo "Operazione completata. Numero totale di file trovati e spostati: $totale"
    rm -f "$counterFile"
fi

exit 0


