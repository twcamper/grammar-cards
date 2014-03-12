# encoding: utf-8

require_relative 'cards/card_base'

Dir["#{LIB_PATH}/cards/*.rb"].each do |rb|
  require rb
end
