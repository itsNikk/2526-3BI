#!/bin/bash
read -a giocatori -p "Inserisci 4 giocatori separati da spazio: "
if [ ${#giocatori[@]} -ne 4 ]; then echo "Errore: servono esattamente 4 giocatori."; exit 1; fi
echo "=== TORNEO ==="
echo "Semifinali:"
v1=$(./partita.sh "${giocatori[0]}" "${giocatori[1]}")
echo "  ${giocatori[0]} vs ${giocatori[1]} -> vince $v1"
v2=$(./partita.sh "${giocatori[2]}" "${giocatori[3]}")
echo "  ${giocatori[2]} vs ${giocatori[3]} -> vince $v2"
echo ""
echo "Finale:"
campione=$(./partita.sh "$v1" "$v2")
echo "  $v1 vs $v2 -> vince $campione"
echo ""
echo "Campione: $campione"
echo "$campione" > campione.txt
