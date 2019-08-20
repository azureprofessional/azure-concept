#!/bin/bash

cd ../
pandoc -i ../about/*.md ../0000-Governance/*.md ../1000-Basic-Infrastructure/*.md -f markdown_github --include-in-header ./pdf/pagebreak.tex --toc -V linkcolor:blue -V geometry:a4paper -V geometry:margin=2cm --pdf-engine=xelatex -o ./pdf/azure-script.pdf