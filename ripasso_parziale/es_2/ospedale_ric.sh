#!/bin/sh

reparto="$1"
shift 
anno="$1"
shift

cd "$anno"

for d in *.txt
do 
    if test -f "$d" -a -r "$d"
    then 
        mese=$(echo "$d" | cut -d '.' -f1)  #delimitatore .txt
        grep -w "$reparto" "$d" | cut -d " " -f 2,4,5 >> "$RICOVERI"
    
        n_ricoveri=`grep -c -w "$reparto" "$d"`
        maxcount=$(cat "$MAX_COUNT")

        if test "$n_ricoveri" -gt "$maxcount"
        then 
            echo "$n_ricoveri" > "$MAX_COUNT"
            echo "$mese $anno" > "$MAX_MONTH"
        fi
    fi    
done

for d in *
do  
    if test -d "$d" -a -x "$d"
    then 
        ospedale_ric.sh "$reparto" "$d"
    fi
done