# encoding: utf-8
require 'spec_helper'

module GrammarCards
  describe Card do
    context 'simple front, simple back' do
      before do
        n ={:esp => "sistema", :gen => :m, :eng => "system"}
        @card = Card.new(n, [{:num => :p}, {:per => 1, :num => :s}], 0)
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
        n = {:esp => "país", :gen => :m, :eng => "country"}
        @card = Card.new(n, [{:num => :p}, {:per => 3, :gen => :f, :num => :p}], 0)
      end
      it "should say 'their countries (f)' on the front" do
        expect(@card.front).to eq 'their countries (f)'
      end

      it "should say 'sus países (los países de ellas)' on the back" do
        expect(@card.back).to eq 'sus países (los países de ellas)'
      end
    end

    context "properties" do
      before do
        n = {:esp => "país", :gen => :m, :eng => "country"}
        @card = Card.new(n, [{:num => :p}, {:per => 3, :gen => :f, :num => :p}], 9)
      end
      it "should know its sequence number" do
        expect(@card.sequence_number).to eq 9
      end
      it "should know if it's been logged yet" do
        expect(@card.logged?).to be false
        @card.set_logged
        expect(@card.logged?).to be true
      end
    end
  end
end
