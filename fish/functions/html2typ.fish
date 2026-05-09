function html2typ -d 'convert html to typst'
    sed -E '
        s#&nbsp;##g;
        s# (style|dir)="[^"]+"##g;
        s#</?(thead|tbody|p|span)>##g' \
        | pandoc -f html -t typst -i - -o - \
        | sed -E '
        s|^  align\(center\)\[||;
        s#^(\#figure\(|  align\(center\)\[|  \)\]|  , kind: table)$##;
        s#^  ##;
        /^  table.hline\(\),$/d;
        /^\s*$/d'
end
