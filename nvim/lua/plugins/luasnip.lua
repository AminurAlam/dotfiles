local M = {
  'https://github.com/L3MON4D3/LuaSnip',
  event = 'InsertEnter',
}

M.config = function()
  local ls = require 'luasnip'
  local t, i = ls.text_node, ls.insert_node

  ls.add_snippets('tex', {
    ls.snippet('verb', { t('\\verb|'), i(1, 'text'), t('|') }),
  })

  -- stylua: ignore
  ls.add_snippets('fish', {
    ls.snippet('local', { t('set -l '), i(1) }),
    ls.snippet('function', {
      t('function '), i(1, 'name'),
      t { '', '    ' }, i(2),
      t { '', 'end' }, i(0)
    }),
    ls.snippet('if', {
      t('if '), i(1, 'cond'),
      t { '', '    ' }, i(2, 'cmd'),
      t { '', 'end' },
    }),
    ls.snippet('elseif', {
      t('else if '), i(1, 'cond'),
      t { '', '    ' }, i(2, 'cmd'),
    }),
    ls.snippet('else', {
      t('else'),
      t { '', '    ' }, i(1, 'cmd'),
    }),
    ls.snippet('switch', {
      t('switch '), i(1, 'value'),
      t { '', '    case ' }, i(2, 'glob'),
      t { '', '        ' }, i(3, 'cmd'),
      t { '', '    case "*"' },
      t { '', '        ' }, i(4, 'cmd'),
      t { '', 'end' }, i(0)
    }),
    ls.snippet('for', {
      t('for '), i(1, 'i'), t(' in '), i(2, 'iterator'),
      t { '', '    ' }, i(3, 'cmd'),
      t { '', 'end' }, i(0)
    }),
    ls.snippet('begin', {
      t('begin'),
      t { '', '    ' }, i(1),
      t { '', 'end' }, i(0)
    }),
    -- NOTE: keep updated
    -- :read! string unescape (abbr) | sed -E 's/^abbr.* -- (\S+) (.*)$/    ls.snippet("\1", { t [[\2]] }),/;s/\%/]], i(1), t [[/;s/, t \[\[\]\] / /'
    ls.snippet("cp", { t [[cp -ivr]] }),
    ls.snippet("mv", { t [[mv -iv]] }),
    ls.snippet("rm", { t [[rm -i]] }),
    ls.snippet("rf", { t [[rm -frI]] }),
    ls.snippet("rd", { t [[rmdir -pv]] }),
    ls.snippet("md", { t [[mkdir -pv]] }),
    ls.snippet("vi", { t [[nvim]] }),
    ls.snippet("cls", { t [[clear]] }),
    ls.snippet("tar", { t [[tar xzf]] }),
    ls.snippet("yq", { t [[yq -oj --xml-attribute-prefix '']] }),
    ls.snippet("qmv", { t [[qmv -AXf do]] }),
    ls.snippet("diff", { t [[diff -Naur]] }),
    ls.snippet("py", { t [[python3 -q]] }),
    ls.snippet("pst", { t [[ps -faxo 'pid,comm' | sed -E "s:$PREFIX/[a-z]+/::"]] }),
    ls.snippet("fstack", { t [[ffmpeg -y -hide_banner -i ]], i(1), t [[ -filter_complex hstack out.png]] }),
    ls.snippet("ff", { t [[ffmpeg -y -hide_banner -stats -loglevel error -i ]], i(1), t [[ -vcodec copy -acodec copy -map 0:a]] }),
    ls.snippet("mbz", { t [[python ~/repos/musicbrainzpy/cover_art.py -o $XDG_MUSIC_DIR/#meta/ ']], i(1), t [[']] }),
    ls.snippet("awk", { t [[awk -F ' ' '{print $]], i(1), t [[}']] }),
    ls.snippet("...", { t [[cd ../..]] }),
    ls.snippet("....", { t [[cd ../../..]] }),
    ls.snippet("gac", { t [[git add ]], i(1), t [[ && git commit]] }),
    ls.snippet("ga", { t [[git add]] }),
    ls.snippet("gc", { t [[git commit]] }),
    ls.snippet("gl", { t [[git status -bs; git log --pretty=nice -n10]] }),
    ls.snippet("gd", { t [[git diff ]], i(1), t [[ | delta]] }),
    ls.snippet("pull", { t [[git pull origin]] }),
    ls.snippet("push", { t [[git push origin]] }),
    ls.snippet("fr", { t [[git fetch upstream && git rebase upstream/(git symbolic-ref refs/remotes/origin/HEAD | sed s@^refs/remotes/origin/@@)]] }),
    ls.snippet("rcp", { t [[rclone copy -P --transfers 8 --]] }),
    ls.snippet("rls", { t [[rclone lsf]] }),
    ls.snippet("rlt", { t [[rclone tree --level]] }),
    ls.snippet("rdu", { t [[rclone size]] }),
    ls.snippet("rconf", { t [[rclone config]] }),
    ls.snippet("du", { t [[dust -Dn 25]] }),
    ls.snippet("dud", { t [[dust -d 1]] }),
    ls.snippet("df", { t [[df -h | awk '/fuse/{print $3"/"$2,$5,$4}']] }),
    ls.snippet("pi", { t [[pacman -S]] }),
    ls.snippet("pr", { t [[pacman -Rs]] }),
    ls.snippet("pu", { t [[pacman -Syu]] }),
    ls.snippet("pf", { t [[pacman -Ss]] }),
    ls.snippet("pa", { t [[pacman -Si]] }),
    ls.snippet("zdl", { t [[z $XDG_DOWNLOAD_DIR/]], i(1) }),
    ls.snippet("zd", { t [[z $XDG_PROJECTS_DIR/dotfiles/]], i(1) }),
    ls.snippet("zf", { t [[z $XDG_PROJECTS_DIR/dotfiles/fish/]], i(1) }),
    ls.snippet("zn", { t [[z $XDG_PROJECTS_DIR/dotfiles/nvim/]], i(1) }),
    ls.snippet("zp", { t [[z $PREFIX/]], i(1) }),
    ls.snippet("zz", { t [[z -]] }),
  })
end

return M
