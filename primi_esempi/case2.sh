#!/bin/bash

echo -n "Vuoi installare l'aggiornamento? [sì/no]: "
read risposta

case "$risposta" in
    S* | s* | Y* | y* )
        echo "Installazione avviata con successo!"
        ;;
    * )
        echo "Operazione annullata."
        ;;
esac