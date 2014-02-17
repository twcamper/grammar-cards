# encoding: utf-8
require 'spec_helper'

module GrammarCards
  module Annotations
    describe "#disambiguate_owner" do
      context "2nd person" do
        it "should say 'singular familiar'" do
          expect(Annotations.disambiguate_owner(
            :person => 2,
            :register => :familiar,
            :number => :s
          )).to eq 'singular familiar'
        end
        it "should say 'plural familiar'" do
          expect(Annotations.disambiguate_owner(
            :person => 2,
            :register => :familiar,
            :number => :p
          )).to eq 'plural familiar'
        end
        it "should say 'singular formal'" do
          expect(Annotations.disambiguate_owner(
            :person => 2,
            :register => :formal,
            :number => :s
          )).to eq 'singular formal'
        end
        it "should say 'plural formal'" do
          expect(Annotations.disambiguate_owner(
            :person => 2,
            :register => :formal,
            :number => :p
          )).to eq 'plural formal'
        end
        it "should raise an error if no register" do
          expect do
            Annotations.disambiguate_owner(
            :person => 2,
            :number => :p
          )
          end.to raise_error 'register required for 2nd person'
        end
      end

      context "3rd person plural" do
        it "should say 'f'" do
          expect(Annotations.disambiguate_owner(
            :person => 3,
            :gender => :f,
            :number => :p
          )).to eq 'f'
        end
        it "should say 'm'" do
          expect(Annotations.disambiguate_owner(
            :person => 3,
            :gender => :m,
            :number => :p
          )).to eq 'm'
        end
        it "should raise an error if no gender" do
          expect do
            Annotations.disambiguate_owner(
            :person => 3,
            :number => :p
          )
          end.to raise_error 'gender required for 3rd person plural'
        end
      end
    end
    # your book
    # s familiar  -- tu libro
    # p familiar  -- vuestro libro
    # s formal    -- su libro/él libro de Ud.
    # p formal    -- su libro/él libro de Uds.

    # your books
    # s familiar  -- tus libros
    # p familiar  -- vuestros libros
    # s formal    -- sus libros/los libros de Ud.
    # p formal    -- sus libros/los libros de Uds.

    # their book
    # feminine  -- su libro/él libro de ellas
    # masculine -- su libro/él libro de ellos
    #
    # their books
    # feminine  -- sus libros/los libros de ellas
    # masculine -- sus libros/los libros de ellos
  end
end

