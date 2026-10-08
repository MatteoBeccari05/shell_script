#!/bin/bash

# Visualizza un messaggio di benvenuto con il nome dell'utente connesso
echo "Ciao, $USER!"

# Mostra la data e l'ora attuali
echo "Data e ora correnti: $(date)"

# Mostra la directory corrente
echo "Ti trovi in: $(pwd)"

# Controlla se esiste una cartella chiamata 'backup'
if [ -d "backup" ]; then
    echo "La cartella 'backup' esiste già."
else
    echo "La cartella 'backup' non esiste. Creazione in corso..."
    mkdir backup
    echo "Cartella 'backup' creata con successo!"
fi
