# encoding: utf-8
require 'spec_helper'

module GrammarCards
  module Syntax

    describe PossessiveNounPhrase do
      it "should return Spanish for feminine plural noun, 3rd masculine plural owner" do
        noun = GrammarCards::Words::Noun.new("pluma f pen", :p)
        phrase = PossessiveNounPhrase.spanish(noun, :person => 3, :gender => :m, :number => :p)
        expect(phrase).to eq 'las plumas de ellos'
      end

      it "should return Spanish for  masculine singular noun, 2nd singular owner" do
        noun = GrammarCards::Words::Noun.new("libro m book", :s)
        phrase = PossessiveNounPhrase.spanish(noun, :person => 2, :number => :s)
        expect(phrase).to eq 'el libro de Ud.'
      end
    end

    describe PossessiveAdjectivalNounPhrase do
      context "singular noun" do
        context "1st plural owner" do
          let(:phrase) do
            PossessiveAdjectivalNounPhrase.new(
              GrammarCards::Words::Noun.new("casa f house", :s),
              :person => 1, :number => :p
            )
          end
          it "should return 'nuestra casa'" do
            expect(phrase.spanish).to eq 'nuestra casa'
          end
          it "should return 'our house'" do
            expect(phrase.english).to eq 'our house'
          end
        end
        context "2nd singular familiar owner" do
          let(:phrase) do
            PossessiveAdjectivalNounPhrase.new(
              GrammarCards::Words::Noun.new("casa f house", :s),
              :person => 2, :number => :s, :register => :familiar
            )
          end
          it "should return 'tu casa'" do
            expect(phrase.spanish).to eq 'tu casa'
          end
          it "should return 'your house'" do
            expect(phrase.english).to eq 'your house'
          end
        end
      end

      context "plural noun" do
        context "feminine noun" do
          let(:n) { GrammarCards::Words::Noun.new("ciudad f city", :p) }
          context "3rd plural masculine owner" do
          let(:phrase) do
            PossessiveAdjectivalNounPhrase.new(
              GrammarCards::Words::Noun.new("ciudad f city", :p),
              :person => 3, :number => :p, :gender => :m
            )
          end
            it "should return 'sus ciudades'" do
              expect(phrase.spanish).to eq 'sus ciudades'
            end
            it "should return 'their cities'" do
              expect(phrase.english).to eq 'their cities'
            end
          end
        end
        context "masculine noun" do
          context "2nd plural familiar owner" do
          let(:phrase) do
            PossessiveAdjectivalNounPhrase.new(
              GrammarCards::Words::Noun.new("mapa m map", :p),
              :person => 2, :number => :p, :register => :familiar
            )
          end
            it "should return 'vuestros mapas'" do
              expect(phrase.spanish).to eq 'vuestros mapas'
            end
            it "should return 'your maps'" do
              expect(phrase.english).to eq 'your maps'
            end
          end
        end
      end
    end

  end
end

