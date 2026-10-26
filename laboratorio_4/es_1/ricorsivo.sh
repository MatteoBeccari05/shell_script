#!/bin/sh

DIR_SORG="$1"
DIR_DEST="$2"

# Spostamento nella directory sorgente
cd "$DIR_SORG" || exit 1

# 1. Esame dei file con estensione .JPG nella directory corrente
for i in *.JPG; do
    # Verifica che il pattern abbia trovato un file reale e leggibile dall'utente
    if test -f "$i" -a -r "$i"; then
        # Controllo se il file esiste gia' nella directory di destinazione
        if test ! -f "$DIR_DEST/$i"; then
            # File non duplicato: spostamento diretto
            mv "$i" "$DIR_DEST/$i"
        else
        # File duplicato: gestione spostamento in dir_destinazione/duplicati
            # Creazione della directory 'duplicati' se non esiste
            if test ! -d "$DIR_DEST/duplicati"; then
                mkdir "$DIR_DEST/duplicati"
            fi

            # Separazione di nome e estensione per rinominare (es. foto.JPG -> foto)
            NOME_BASE=`echo "$i" | sed 's/\.JPG$//'`

            # Ricerca del primo nome disponibile: nomefile-1.JPG, nomefile-2.JPG, ecc.
            NUMERO=1
            NUOVO_NOME="${NOME_BASE}-${NUMERO}.JPG"

            while test -f "$DIR_DEST/duplicati/$NUOVO_NOME"; do
                NUMERO=`expr $NUMERO + 1`
                NUOVO_NOME="${NOME_BASE}-${NUMERO}.JPG"
            done

            # Spostamento e rinomina del file duplicato
            mv "$i" "$DIR_DEST/duplicati/$NUOVO_NOME"
        fi
    fi
done


# 2. Esplorazione ricorsiva delle sottodirectory
for d in *; do
    if test -d "$d" -a ! -L "$d"; then
        # Invocazione ricorsiva evitando link simbolici
        ricorsivo.sh "$DIR_SORG/$d" "$DIR_DEST"
    fi
done