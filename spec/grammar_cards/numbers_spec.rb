# encoding: utf-8
require 'spec_helper'

module GrammarCards
  module Numbers
    describe "#spanish_words_for" do
      it "should translate 0" do
        expect(Numbers.spanish_words_for(0)).to eq 'cero'
      end
      it "should translate 1" do
        expect(Numbers.spanish_words_for(1)).to eq 'uno'
      end
      it "should translate 16" do
        expect(Numbers.spanish_words_for(16)).to eq 'dieciséis'
      end
      it "should translate 29" do
        expect(Numbers.spanish_words_for(29)).to eq 'veintinueve'
      end
      it "should translate 30" do
        expect(Numbers.spanish_words_for(30)).to eq 'treinta'
      end
      it "should translate 41" do
        expect(Numbers.spanish_words_for(41)).to eq 'cuarenta y uno'
      end
      it "should translate 56" do
        expect(Numbers.spanish_words_for(56)).to eq 'cincuenta y seis'
      end
      it "should translate 99" do
        expect(Numbers.spanish_words_for(99)).to eq 'noventa y nueve'
      end
      it "should translate 100" do
        expect(Numbers.spanish_words_for(100)).to eq 'cien'
      end
      it "should translate 101" do
        expect(Numbers.spanish_words_for(101)).to eq 'ciento uno'
      end
      it "should translate 200" do
        expect(Numbers.spanish_words_for(200)).to eq 'doscientos'
      end
      it "should translate 358" do
        expect(Numbers.spanish_words_for(358)).to eq 'trescientos cincuenta y ocho'
      end
      it "should translate 999" do
        expect(Numbers.spanish_words_for(999)).to eq 'novecientos noventa y nueve'
      end
      it "should translate 1000" do
        expect(Numbers.spanish_words_for(1000)).to eq 'mil'
      end
      it "should translate 1009" do
        expect(Numbers.spanish_words_for(1009)).to eq 'mil nueve'
      end
      it "should translate 1492" do
        expect(Numbers.spanish_words_for(1492)).to eq 'mil cuatrocientos noventa y dos'
      end
      it "should translate 6000" do
        expect(Numbers.spanish_words_for(6000)).to eq 'seis mil'
      end
      it "should translate 8001" do
        expect(Numbers.spanish_words_for(8001)).to eq 'ocho mil uno'
      end
      it "should translate 9999" do
        expect(Numbers.spanish_words_for(9999)).to eq 'nueve mil novecientos noventa y nueve'
      end
      it "should translate 60001" do
        expect(Numbers.spanish_words_for(60001)).to eq 'sesenta mil uno'
      end
      it "should translate 70000" do
        expect(Numbers.spanish_words_for(70000)).to eq 'setenta mil'
      end
      it "should translate 380514" do
        expect(Numbers.spanish_words_for(580714)).to eq 'quinientos ochenta mil setecientos catorce'
      end
      it "should translate 400000" do
        expect(Numbers.spanish_words_for(400000)).to eq 'cuatrocientos mil'
      end
      it "should translate 999999" do
        expect(Numbers.spanish_words_for(999999)).to eq 'novecientos noventa y nueve mil novecientos noventa y nueve'
      end
      it "should translate -234" do
        expect(Numbers.spanish_words_for(-234)).to eq 'menos doscientos treinta y cuatro'
      end
    end

    describe "#equation" do
      it "should solve and translate '12 + 432'" do
        expect(Numbers.equation(12, 432, :+)).to eq ["doce", "más", "cuatrocientos treinta y dos", "son", "cuatrocientos cuarenta y cuatro"]
      end
      it "should solve and translate '300 - 55'" do
        expect(Numbers.equation(300, 55, :-)).to eq ["trescientos", "menos", "cincuenta y cinco", "son", "doscientos cuarenta y cinco"]
      end
    end
  end
end
