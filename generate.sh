#!/bin/bash

set -e

mkdir -p outputs

for lang in en es; do
    for style in technical executive; do
        echo "Generating $style ($lang) ..."

        pandoc content/$lang.md \
            --metadata-file=metadata/$lang.yaml \
            --template=templates/$style.latex \
            --pdf-engine=xelatex \
            -o outputs/${style}_${lang}.pdf

        pandoc content/$lang.md \
            --metadata-file=metadata/$lang.yaml \
            --reference-doc=templates/reference.docx \
            -o outputs/${style}_${lang}.docx

        pandoc content/$lang.md \
            --metadata-file=metadata/$lang.yaml \
            --template=templates/$style.html \
            -o outputs/${style}_${lang}.html
    done
done

[ -f templates/index.html ] && cp templates/index.html outputs/index.html

echo "Build complete!"
