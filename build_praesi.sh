out=${1:-praesi.pptx}
files="Einfuehrung.md Grundlagen.md LinearEinfach.md LinearKomplex.md Branching.md Remotes.md"

cat $files | m2ppp
echo "$(cat $files | wc -l) lines" 
