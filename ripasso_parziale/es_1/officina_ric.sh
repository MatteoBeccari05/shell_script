#!/bin/sh

categoria="$1"
shift
anno="$1"
shift

cd "$anno"

# Esplorazione dei file .txt nella directory corrente
for f in *.txt
do
    if test -f "$f" -a -r "$f"
    then 
        # Estrazione del nome del mese (nome file senza estensione)
        mese=`echo "$f" | cut -f1 -d "."`
        
        # Estrazione del numero di interventi della categoria specificata
        num_int=`grep " $categoria$" "$f" | cut -f1 -d " "`
        if test -z "$num_int"
        then
            num_int=`grep "$categoria" "$f" | cut -f1 -d " "`
        fi

        # Se trovata, aggiunta della riga al log
        if test ! -z "$num_int"
        then 
            echo "$mese $num_int" >> "$RIEPILOGO"
        fi

        # Ricerca del valore massimo globale (tra tutte le categorie nel file)
        riga_max=`sort -n "$f" | tail -n 1`

        if test ! -z "$riga_max"
        then 
            val=`echo "$riga_max" | cut -f1 -d " "`
            cat_max=`echo "$riga_max" | cut -f2 -d " "`

            max_att=`cat "$MAX_COUNT"`
            if test "$val" -gt "$max_att"
            then 
                echo "$val" > "$MAX_COUNT"
                echo "$cat_max" > "$MAX_CAT"
            fi
        fi
    fi
done

# Esplorazione ricorsiva delle sottodirectory
for d in *
do
    if test -d "$d" -a ! -L "$d" -a -x "$d"
    then 
        officina_ric.sh "$categoria" "$d"
    fi
done