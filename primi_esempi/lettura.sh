#!/bin/bash

# 1. Stampa una domanda a schermo
echo -n "Come ti chiami? "

# 2. Legge l'input dell'utente e lo salva nella variabile NOME
read NOME

# 3. Stampa un messaggio usando il valore inserito
echo "Ciao $NOME, piacere di conoscerti!"

# 4. Esegue un comando di sistema e ne mostra il risultato
echo "Oggi è il: $(date +'%d/%m/%Y')"
