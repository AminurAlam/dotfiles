pacman -S --noconfirm --needed clang cmake make openssl binutils perl libuv

for repo in luvi luvit lit
    git clone --recursive --depth 1 "https://github.com/luvit/$repo" "$repo-src"
end

cd luvi-src || exit 1

make regular
make test
make luvi

mv build/luvi ../
cd ../

./luvi lit-src -- make lit-src
