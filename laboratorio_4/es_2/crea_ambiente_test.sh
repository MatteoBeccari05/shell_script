#!/bin/bash


BASE_DIR="/tmp/test_progetti"

echo "Creazione ambiente di test in: $BASE_DIR..."


rm -rf "$BASE_DIR"


mkdir -p "$BASE_DIR/Progetto_Alpha/src"
mkdir -p "$BASE_DIR/Progetto_Beta/modules"
mkdir -p "$BASE_DIR/Progetto_Gamma"


cat << 'EOF' > "$BASE_DIR/Progetto_Alpha/src/main.log"
main.c,Progetto_Alpha,2026-10-26 09:00:00,error,14,errore di sintassi: ';' mancante,GCC 11.2
main.c,Progetto_Alpha,2026-10-26 09:00:01,warning,25,variabile 'count' non utilizzata,GCC 11.2
utils.c,Progetto_Alpha,2026-10-26 09:00:05,error,88,conversione di tipo implicita non valida,GCC 11.2
EOF



cat << 'EOF' > "$BASE_DIR/Progetto_Beta/core.log"
core.c,Progetto_Beta,2026-10-26 09:10:00,error,10,riferimento non valido a puntatore NULL,GCC 11.2
core.c,Progetto_Beta,2026-10-26 09:10:02,error,45,funzione 'process_data' non dichiarata,GCC 11.2
core.c,Progetto_Beta,2026-10-26 09:10:05,warning,102,confronto tra interi con e senza segno,GCC 11.2
EOF


cat << 'EOF' > "$BASE_DIR/Progetto_Beta/modules/network.log"
network.c,Progetto_Beta,2026-10-26 09:12:00,error,50,timeout connessione socket,GCC 11.2
network.c,Progetto_Beta,2026-10-26 09:12:01,warning,12,buffer ridotto,GCC 11.2
network.c,Progetto_Beta,2026-10-26 09:12:02,message,100,modulo caricato correttamente,GCC 11.2
EOF


cat << 'EOF' > "$BASE_DIR/Progetto_Gamma/app.log"
app.c,Progetto_Gamma,2026-10-26 09:20:00,message,1,compilazione iniziata,GCC 11.2
app.c,Progetto_Gamma,2026-10-26 09:20:05,warning,30,direttiva deprecata utilizzata,GCC 11.2
EOF


chmod -R 755 "$BASE_DIR"

echo "Ambiente di test creato con successo!"
echo ""
echo "Esempio di riga presente in uno dei file .log:"
head -n 1 "$BASE_DIR/Progetto_Alpha/src/main.log"


#./trova_errori /tmp/test_progetti