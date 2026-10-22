#!/bin/sh

# Ricezione parametri
dir=$1
max_counter=$2
max_dirname=$3

# Entrata nella directory da analizzare
cd "$dir" || exit 1

# Inizializzazione del contatore locale per la directory corrente
counter=0


# SCANSIONE DEI FILE .TXT
for f in *.txt
do
    # Verifica che sia un file regolare esistente
    if test -f "$f"
    then
        # Verifica del diritto di scrittura dell'utente sul file (-w)
        if test -w "$f"
        then
            # Estrazione della prima riga (#titolo,autore,versione,data) con head
            # ed estrazione del 3° campo (versione) separato da virgola con cut
            versione=`head -n 1 "$f" | cut -d',' -f3`

            # Controllo se il valore estratto equivale a "preliminare"
            if test "$versione" = "preliminare"
            then
                # Incremento del contatore locale
                counter=`expr $counter + 1`

                # Rimozione del file
                rm -f "$f"
            fi
        fi
    fi
done


# AGGIORNAMENTO DEI MASSIMI
max_val=`cat "$max_counter"`

# Se il numero di file cancellati nella directory corrente e' maggiore del massimo globale
if test "$counter" -gt "$max_val"
then
    echo "$counter" > "$max_counter"
    pwd > "$max_dirname"
fi


# ESPLORAZIONE RICORSIVA DELLE SOTTODIRECTORY

for d in *
do
    if test -d "$d"
    then
        # Controllo il diritto di esecuzione/attraversamento sulla directory
        if test -x "$d"
        then
            cancella_versioni_preliminari_aux.sh "`pwd`/$d" "$max_counter" "$max_dirname"
        fi
    fi
done

exit 0