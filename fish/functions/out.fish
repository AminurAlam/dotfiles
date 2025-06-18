function out -d "compile and run some code"
    clear

    switch (path extension $argv[1])
        case .c
            cc -lm -lGL -lGLU -lglut -oout -Wno-all $argv[1]
            ./out
            rm out
        case .rs
            rustc -oout -- $argv[1]
            ./out
            rm out
        case .tex
            latexmk -pdf -interaction=nonstopmode -synctex=1 $argv[1]
            open (path change-extension pdf "$argv[1]")
            latexmk -c
        case "*"
    end
end
