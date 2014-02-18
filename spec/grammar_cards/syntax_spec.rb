# encoding: utf-8
require 'spec_helper'

module GrammarCards
  module Syntax

    describe PossessiveNounPhrase do
      it "should return Spanish for feminine plural noun, 3rd masculine plural owner" do
        noun = GrammarCards::Words::Noun.new(:esp => "pluma", :gen => :f, :eng => "pen", :num => :p)
        phrase = PossessiveNounPhrase.spanish(noun, :per => 3, :gen => :m, :num => :p)
        expect(phrase).to eq 'las plumas de ellos'
      end

      it "should return Spanish for  masculine singular noun, 2nd singular owner" do
        noun = GrammarCards::Words::Noun.new(:esp => "libro", :gen => :m, :eng => "book",:num => :s)
        phrase = PossessiveNounPhrase.spanish(noun, :per => 2, :num => :s)
        expect(phrase).to eq 'el libro de Ud.'
      end
    end

    describe PossessiveAdjectivalNounPhrase do
      context "singular noun" do
        context "1st plural owner" do
          let(:phrase) do
            PossessiveAdjectivalNounPhrase.new(
              GrammarCards::Words::Noun.new(:esp => "casa", :gen => :f, :eng => "house", :num => :s),
              :per => 1, :num => :p
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
              GrammarCards::Words::Noun.new(:esp => "casa", :gen => :f, :eng => "house", :num => :s),
              :per => 2, :num => :s, :reg => :familiar
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
          let(:n) { GrammarCards::Words::Noun.new(:esp => "ciudad", :gen => :f, :eng => "city", :num => :p) }
          context "3rd plural masculine owner" do
          let(:phrase) do
            PossessiveAdjectivalNounPhrase.new(
              GrammarCards::Words::Noun.new(:esp => "ciudad", :gen => :f, :eng => "city", :num => :p),
              :per => 3, :num => :p, :gen => :m
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
              GrammarCards::Words::Noun.new(:esp => "mapa", :gen => :m, :eng => "map", :num => :p),
              :per => 2, :num => :p, :reg => :familiar
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

