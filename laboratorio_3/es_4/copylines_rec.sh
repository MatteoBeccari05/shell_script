#!/bin/sh

dir_corrente="$1"
stringa="$2"

shift 2
# Ora $@ contiene solo la lista dei file passati come parametro

# Spostamento nella directory da esplorare
cd "$dir_corrente" || exit 1

for item in *; do
    # Gestione directory vuota (se * non espande alcun file)
    if test ! -e "$item" -a ! -L "$item"; then
        continue
    fi

    # Se l'elemento è una directory (e non un link simbolico)
    if test -d "$item" -a ! -L "$item"; then
        # Verifica permessi di lettura ed esecuzione
        if test -r "$item" -a -x "$item"; then
            copylines_rec.sh "$dir_corrente/$item" "$stringa" "$@"
        fi
    fi

    # Se l'elemento è un file regolare
    if test -f "$item"; then
        # Verifichiamo se il file coincide con uno di quelli cercati
        for target in "$@"; do
            if test "$item" = "$target"; then
                # Verifichiamo se il file contiene la stringa cercata (-F ricerca stringa fissa)
                grep -F "$stringa" "$item" > /dev/null 2>&1
                if test $? -eq 0; then
                    # Salviamo le linee trovate nel file temporaneo
                    grep -F "$stringa" "$item" >> "$TMP_LINES"
                    # Registriamo lo spostamento
                    echo "$dir_corrente/$item" >> "$TMP_MOVED"
                    # Spostiamo il file in /tmp (sovrascrive eventuali file con lo stesso nome)
                    mv -f "$item" /tmp
                fi
                break
            fi
        done
    fi
done