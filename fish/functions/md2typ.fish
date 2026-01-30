function md2typ -d 'convert markdown to typst'
    wl-paste \
        | prettier --parser markdown \
        | sed -E '
            s/\*+//g;
            s/\\\*//g;
            s/^---$//' \
        | pandoc -f markdown -t typst -i - -o - --columns 85 \
        | sed -E '
            /^<[a-zA-Z-]+>$/d;
            s|^- |/ |;
            s|’|\'|;
            s/^===/==/'
end
