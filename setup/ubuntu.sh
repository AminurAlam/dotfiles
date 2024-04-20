#!/usr/bin/env bash

command -vq sudo && sudo=sudo

$sudo apt-add-repository ppa:fish-shell/release-2
$sudo apt-get update
$sudo apt-get install fish

# sudo apt-get -y install git gettext automake autoconf ncurses-dev build-essential libncurses5-dev
#
# git clone -q --depth 1 https://github.com/fish-shell/fish-shell
# cd fish-shell
# autoreconf && ./configure
# make && sudo make install
