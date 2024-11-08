out=${1:-praesi.pptx}
files="Einfuehrung.md Grundlagen.md LinearEinfach.md LinearKomplex.md Branching.md Remotes.md"

cat $files | pandoc -o $out -M "monofont=Courier New" -
echo "$(cat $files | wc -l) lines" 
