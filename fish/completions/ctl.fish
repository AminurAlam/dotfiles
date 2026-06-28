complete --command ctl -fka "(rg --only-matching --replace '\$1' '^    case ([^ ]+)' (command -v ctl) )"
