#!/bin/bash

# Personalizza il testo del prompt (di default sarebbe #?)
PS3="Scegli un'operazione inserendo il numero corrispondente: "

# Il comando 'select' crea un menu numerato automatico dalle opzioni fornite
select scelta in "stampa" "cancella" "mostra data" "esci"
do
    case "$scelta" in
        "stampa")
            echo "-> Stampa in corso..."
            ;;
        "cancella")
            echo "-> Eliminazione file completata!"
            ;;
        "mostra data")
            echo "-> Data attuale: $(date +'%d/%m/%Y %H:%M')"
            ;;
        "esci")
            echo "Uscita dal programma."
            break  # Interrompe il ciclo select
            ;;
        *)
            echo "Opzione non valida. Inserisci un numero tra 1 e 4."
            ;;
    esac
    echo "" # Riga vuota di separazione tra le scelte
done