#!/bin/sh

# Controllo del numero di parametri (deve essere esattamente 1)
if test $# -ne 1
then
    echo "Errore: Numero di parametri errato."
    echo "Uso: $0 dir_articoli"
    exit 1
fi

dir_articoli=$1

# Controllo che dir_articoli sia un percorso RELATIVO (non deve iniziare con '/')
case "$dir_articoli" in
    /*)
        echo "Errore: '$dir_articoli' deve essere un percorso relativo."
        exit 2
        ;;
esac

# Controllo che dir_articoli sia una directory esistente
if test ! -d "$dir_articoli"
then
    echo "Errore: '$dir_articoli' non e' una directory valida o esistente."
    exit 3
fi

# AGGIUNTA DELLA DIRECTORY CORRENTE A $PATH
PATH=$PATH:`pwd`
export PATH

# 3. CREAZIONE DEI FILE TEMPORANEI CON PERCORSO ASSOLUTO
max_counter="`pwd`/max_counter.tmp"
max_dirname="`pwd`/max_dirname.tmp"

# Inizializzazione di max_counter.tmp con il valore 0 e svuotamento di max_dirname.tmp
echo 0 > "$max_counter"
> "$max_dirname"


# Convertiamo dir_articoli in percorso assoluto per garantire il cd ricorsivo corretto
cancella_versioni_preliminari_aux.sh "`pwd`/$dir_articoli" "$max_counter" "$max_dirname"

#stampa a video 
if test -s "$max_dirname"
then
    risultato=`cat "$max_dirname"`
    max_deleted=`cat "$max_counter"`
    echo "La directory con il maggior numero di file cancellati ($max_deleted file) e':"
    echo "$risultato"
else
    echo "Nessun file di versione preliminare trovato da cancellare."
fi

# Rimozione dei file temporanei
rm -f "$max_counter" "$max_dirname"

exit 0