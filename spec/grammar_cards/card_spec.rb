# encoding: utf-8
require 'spec_helper'

module GrammarCards
  describe Card do
    context 'simple front, simple back' do
      before do
        n = GrammarCards::Words::Noun.new(:num => :p, :esp => "sistema", :gen => :m, :eng => "system")
        @card = Card.new(n, {:per => 1, :num => :s})
      end
      it "should say 'my systems' on the front" do
        expect(@card.front).to eq 'my systems'
      end

      it "should say 'mis sistemas' on the back" do
        expect(@card.back).to eq 'mis sistemas'
      end
    end

    context 'annotated front, annotated back' do
      before do
        n = GrammarCards::Words::Noun.new(:num => :p, :esp => "país", :gen => :m, :eng => "country")
        @card = Card.new(n, {:per => 3, :gen => :f, :num => :p})
      end
      it "should say 'their countries (f)' on the front" do
        expect(@card.front).to eq 'their countries (f)'
      end

      it "should say 'sus países (los países de ellas)' on the back" do
        expect(@card.back).to eq 'sus países (los países de ellas)'
      end
    end
  end
end
