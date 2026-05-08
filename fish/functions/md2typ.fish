function md2typ -d 'convert markdown to typst'
    sed -E 's/\*\*//g;' \
        | prettier --parser markdown \
        | sed -E '
            s/\*+//g;
            s/\\\*//g;
            s/^---$//' \
        | pandoc -f markdown -t typst -i - -o - --columns 85 \
        | sed -E '
            s/^<[.a-zA-Z0-9-]+>$//;
            s|^- |/ |;
            s|^\+ |+ / |;
            s|’|\'|;
            s/^===/==/;
            s/^== [0-9]+\. /== /;'
end
