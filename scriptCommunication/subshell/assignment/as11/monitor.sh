#!/bin/bash
read -a dirs -p "Directory da monitorare (separate da spazio): "
read -p "Soglia in KB: " soglia
if [ ${#dirs[@]} -eq 0 ] || ! [ $soglia -eq $soglia ] 2>/dev/null || [ $soglia -le 0 ]; then
    echo "Errore: input non valido."; exit 1
fi
ok=0
avvisi=0
for d in "${dirs[@]}"; do
    dim=$(./uso_disco.sh "$d")
    ./soglia_ok.sh $dim $soglia
    if [ $? -eq 0 ]; then
        echo "OK     $d: ${dim}KB"
        ok=$((ok + 1))
    else
        echo "AVVISO $d: ${dim}KB supera la soglia di ${soglia}KB"
        avvisi=$((avvisi + 1))
    fi
done
echo ""
echo "Directory OK: $ok | Avvisi: $avvisi"
