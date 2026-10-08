#!/bin/bash

# 1. Controllo che sia stato passato almeno un argomento
if [ "$#" -lt 1 ]; then
    echo "Uso: $0 <percorso_assoluto_file>" >&2
    exit 1
fi

# 2. Verifica che il primo argomento sia un percorso assoluto e un file esistente
case "$1" in
    /*) 
        # Inizia con '/', quindi è un percorso assoluto. Ora verifichiamo se è un file.
        if [ ! -f "$1" ]; then
            echo "Errore: '$1' non è un file valido o non esiste." >&2
            exit 2
        fi
        ;;
    *) 
        # Non inizia con '/', quindi non è un percorso assoluto.
        echo "Errore: '$1' deve essere un percorso assoluto (deve iniziare con /)." >&2
        exit 3
        ;;
esac

# 3. Se i controlli sono superati con successo:
echo "Ottimo! '$1' è un percorso assoluto ed è un file esistente."

#FUNZIONAMENTO
# ./es_2.sh /etc/passwd
# Ottimo! '/etc/passwd' è un percorso assoluto ed è un file esistente.