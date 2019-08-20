#!/bin/bash

cd ../
pandoc -i ../about/*.md ../0000-Governance/*.md ../1000-Basic-Infrastructure/*.md --reference-doc=./word/custom-reference.docx --toc --metadata-file=./word/metadata.yml -o ./word/azure-script.docx

read  -n 1 -p "Done. Press any button to exit.