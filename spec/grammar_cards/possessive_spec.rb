# encoding: utf-8
require 'spec_helper'

module GrammarCards
  module Possessive
    describe Pronoun do
      it "should return 3rd person feminine singular" do
        expect(Pronoun.pronoun(3, :s, :f)).to eq 'ella'
      end
    end
  end
end
