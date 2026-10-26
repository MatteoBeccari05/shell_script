#!/bin/bash

DIR_CORRENTE="$1"
CONTEGGIO_ERRORI_DIR=0

# --- FASE 1: Esplorazione e analisi dei file .log nella directory corrente ---
for elemento in "$DIR_CORRENTE"/*
do
    # Gestione del caso in cui la cartella sia vuota o la wildcard non trovi corrispondenze
    if test ! -e "$elemento"
    then
        break
    fi

    # Filtro sui file con estensione .log
    case "$elemento" in
        *.log)
            # Verifica che sia un file regolare e che ci siano i permessi di lettura
            if test -f "$elemento" -a -r "$elemento"
            then
                # Lettura del file .log riga per riga dividendo per virgola (IFS=',')
                while IFS=',' read -r nome_sorgente nome_progetto timestamp tipo riga dettagli altre
                do
                    if test "$tipo" = "error"
                    then
                        echo "$nome_progetto,$nome_sorgente,$dettagli" >> "$FILE_ERRORI"
                        CONTEGGIO_ERRORI_DIR=`expr $CONTEGGIO_ERRORI_DIR + 1`
                    elif test "$tipo" = "warning"
                    then
                        echo "$nome_progetto,$nome_sorgente,$dettagli" >> "$FILE_WARNING"
                    fi
                done < "$elemento"
            fi
            ;;
    esac
done

# Se sono stati trovati errori nella directory corrente, salviamo il conteggio nel file temporaneo
if test "$CONTEGGIO_ERRORI_DIR" -gt 0
then
    echo "$CONTEGGIO_ERRORI_DIR $DIR_CORRENTE" >> "$FILE_TMP"
fi

# --- FASE 2: Ricorsione sulle sottodirectory ---
for elemento in "$DIR_CORRENTE"/*
do
    if test ! -e "$elemento"
    then
        break
    fi

    # Se e' una directory ed e' leggibile e attraversabile
    if test -d "$elemento" -a -r "$elemento" -a -x "$elemento"
    then
        trova_errori_ric.sh "$elemento"
    fi
done