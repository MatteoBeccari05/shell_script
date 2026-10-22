#!/bin/sh

# Ricezione parametri
stringa=$1
dir=$2
num=$3
max_counter=$4
max_dirname=$5

# Entro nella directory
cd "$dir" || exit 1

# Creazione/svuotamento del file temporaneo locale per la directory corrente
> counter.tmp

# Scansione dei file txt
for f in *.txt
do
    # Controllo che sia un file regolare esistente (evita problemi se *.txt non trova nulla)
    if test -f "$f"
    then
        # Controllo che l'utente abbia i diritti di lettura sul file
        if test -r "$f"
        then
            # Conta in quante righe del file compare la stringa cercata.
            cnt=`grep "$stringa" "$f" | wc -l`

            # Verifica se la stringa compare in ALMENO 'num' righe (maggiore o uguale)
            if test "$cnt" -ge "$num"
            then
                # Scrittura di una riga nel file counter.tmp per tracciare il file trovato
                echo "$f" >> counter.tmp
            fi
        fi
    fi
done

# Aggiornamento del massimo 
n_curr=`wc -l < counter.tmp`
n_max=`wc -l < "$max_counter"`

# Se il numero di file trovati nella directory corrente e' strettamente maggiore del massimo trovato finora
if test "$n_curr" -gt "$n_max"
then
    # Aggiorna max_counter.tmp copiandovi le righe del counter.tmp attuale
    cp counter.tmp "$max_counter"
    # Aggiorna max_dirname.tmp scrivendovi il percorso assoluto della directory corrente
    pwd > "$max_dirname"
fi

# Esplorazione ricorsiva delle sottodirectory
for d in *
do
    # Se l'elemento e' una directory
    if test -d "$d"
    then
        # Se l'utente ha i diritti di esecuzione/attraversamento sulla directory
        if test -x "$d"
        then
            # Chiamata ricorsiva passando il percorso completo della sottodirectory
            cercaStringa.sh "$stringa" "`pwd`/$d" "$num" "$max_counter" "$max_dirname"
        fi
    fi
done

# Pulizia del file temporaneo locale prima di terminare la funzione/script
rm -f counter.tmp

exit 0