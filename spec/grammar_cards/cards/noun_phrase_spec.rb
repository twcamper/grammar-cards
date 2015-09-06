# encoding: utf-8
require 'spec_helper'

module GrammarCards
  module Cards

    describe NounPhrase do
      context 'simple front, simple back' do
        before do
          n ={:esp => "sistema", :gen => :m, :eng => "system", :rnk => 100}
          @card = NounPhrase.new(n,nil)
        end
        it "should say 'the system' on the front" do
          expect(@card.front).to eq 'system'
        end

        it "should say 'los sistemas' on the back" do
          expect(@card.back).to eq "el sistema\n\n(100)"
        end
      end

      context "properties" do
        before do
          n = {:esp => "país", :gen => :m, :eng => "country"}
          @card = NounPhrase.new(n,nil)
        end
        it "should know its sequence number" do
          @card.sequence_number = 9
          expect(@card.sequence_number).to eq 9
        end
        it "should know if it's been logged yet" do
          expect(@card.done?).to be false
          @card.mark_done
          expect(@card.done?).to be true
        end
      end
    end
  end
end
