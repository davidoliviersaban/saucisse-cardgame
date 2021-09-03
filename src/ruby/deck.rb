require 'squib'

board = Squib.csv file: 'src/resources/board_cards.csv'
deck = Squib.csv file: 'src/resources/deck_cards.csv'

def drawCards(deck,dirname)
  rect layout: :bleed
#  rect layout: 'cut', stroke_color: :black # cut line as defined by TheGameCrafter
  cut_zone radius: 0.0,  stroke_color: :black
#  rect layout: :frame # safe zone as defined by TheGameCrafter
  rect layout: :frame, fill_color: :white
  rect layout: :inside
#  safe_zone radius: 0.0, stroke_color: :red

  png file: deck["Image"].map{ |img| "src/resources/images/"+img}, layout: "Image"

  text str: deck["Nom"], layout: "Nom"

  save_png prefix: deck["Nom"], dir: dirname
end


Squib::Deck.new(cards: board["Nom"].size,
                layout: %w(src/resources/Vlayout.yml src/resources/Vcards.yml),
                width: '2.75in', height: '3.75in') do
  drawCards(board,'_board')
end

Squib::Deck.new(cards: deck["Nom"].size,
                layout: %w(src/resources/Vlayout.yml src/resources/Vcards.yml),
                width: '2.75in', height: '3.75in') do
  drawCards(deck,'_cards')
end