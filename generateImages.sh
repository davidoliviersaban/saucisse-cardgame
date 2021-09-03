#!/usr/bin/env bash
rm -rf _cards* _board _output imagesToPrint
ruby src/ruby/deck.rb
cd ../printableCardsAppender
./gradlew appendCard --args="../saucisse-cardgame/_board ../saucisse-cardgame/imagesToPrint/board A3 true"
./gradlew appendCard --args="../saucisse-cardgame/_cards ../saucisse-cardgame/imagesToPrint/cards A4 false"
#./gradlew run --args="../windwalkers-cardgame/_cards2   ../windwalkers-cardgame/imagesToPrint/cards_v2_ A4 false"