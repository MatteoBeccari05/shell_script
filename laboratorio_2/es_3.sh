#!/bin/sh

if test $# -ne 2
then
    echo "Uso: $0 <directory_assoluta> <nomefile>"
    exit 1
fi

dir="$1"

case "$dir" in 
    /*) ;;
    *) 
        echo "La directory deve essere un percorso assoluto"
        exit 2
        ;;
esac

if test ! -d "$dir"
then 
    echo "Directory non trovata"
    exit 3
fi

file="$2"
PATH=$PATH:`pwd`
export PATH

# Verifica permessi di esecuzione sulla directory
if test -x "$dir"
then    
    cd "$dir"
    for i in *
    do
        # Gestione directory vuota
        if test ! -e "$i"
        then
            break
        fi

        if test -d "$i"
        then
            # Chiamata ricorsiva con il percorso assoluto della sottodirectory
            es_3.sh `pwd`/"$i" "$file"
        else
            if test -f "$i" -a "$i" = "$file"
            then 
                echo "Trovato $i in `pwd`/$i"
            fi
        fi
    done
fi