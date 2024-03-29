#!/usr/bin/env bash

set -o errexit -o noclobber -o pipefail

RUBY_VERSION=3.0.3

if ! command -v rbenv &> /dev/null; then
    brew install rbenv ruby-build gobject-introspection gdk-pixbuf
else
    echo "rbenv already installed"
fi

if ! ruby -v | grep $RUBY_VERSION; then
    if ! rbenv versions | grep $RUBY_VERSION; then
        rbenv install $RUBY_VERSION && echo "ruby $RUBY_VERSION installed"
    fi
    rbenv global $RUBY_VERSION
else
    echo "ruby $RUBY_VERSION already installed"
fi

eval "$(rbenv init - zsh)"
gem env

local_install_printableCardAppender() {
    cd ..
    git clone https://github.com/davidoliviersaban/printableCardsAppender.git
    ./gradlew build
}

rbenv global $RUBY_VERSION
gem list | grep pkg-config || gem install pkg-config && echo "pkg-config installed"
gem list | grep squib || gem install squib && echo "squib installed" || local_install_squib
gem update --system


rm -rf _cards* _board _output imagesToPrint
ruby src/ruby/deck.rb
cd ../printableCardsAppender
./gradlew appendCard --args="../saucisse-cardgame/_board ../saucisse-cardgame/imagesToPrint/board A3 true"
./gradlew appendCard --args="../saucisse-cardgame/_cards ../saucisse-cardgame/imagesToPrint/cards A4 false"
#./gradlew run --args="../windwalkers-cardgame/_cards2   ../windwalkers-cardgame/imagesToPrint/cards_v2_ A4 false"