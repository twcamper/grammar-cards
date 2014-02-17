# encoding: utf-8
require 'spec_helper'

module GrammarCards
  module Words
    describe PossessivePronoun, "#spanish" do
      it "should return 2nd person singular" do
        expect(PossessivePronoun.spanish(2, :s)).to eq 'Ud.'
      end

      it "should return 2nd person plural" do
        expect(PossessivePronoun.spanish(2, :p)).to eq 'Uds.'
      end

      it "should return 3rd person masculine singular" do
        expect(PossessivePronoun.spanish(3, :s, :m)).to eq 'él'
      end

      it "should return 3rd person feminine singular" do
        expect(PossessivePronoun.spanish(3, :s, :f)).to eq 'ella'
      end

      it "should return 3rd person feminine plural" do
        expect(PossessivePronoun.spanish(3, :p, :f)).to eq 'ellas'
      end

      it "should return 3rd person masculine plural" do
        expect(PossessivePronoun.spanish(3, :p, :m)).to eq 'ellos'
      end

    end

    describe PossessiveAdjective do
      context "1st singular owner, singular noun: (mi)" do
        before do
          @adj = PossessiveAdjective.new(
            {:person => 1, :number => :s},
            {:number => :s}
          )
        end
        it("should return Spanish") { expect(@adj.spanish).to eq 'mi' }
        it("should return English") { expect(@adj.english).to eq 'my' }
      end

      context "1st singular owner, pluaral noun: (mis)" do
        before do
          @adj = PossessiveAdjective.new(
            {:person => 1, :number => :s},
            {:number => :p}
          )
        end
        it("should return Spanish") { expect(@adj.spanish).to eq 'mis' }
        it("should return English") { expect(@adj.english).to eq 'my' }
      end

      context "1st plural owner, singular noun: (neustro/a)" do
        context "masculine noun" do
          before do
            @adj = PossessiveAdjective.new(
              {:person => 1, :number => :p},
              {:number => :s, :gender => :m}
            )
          end
          it("should return Spanish") { expect(@adj.spanish).to eq 'nuestro' }
          it("should return English") { expect(@adj.english).to eq 'our' }
        end
        context "feminine noun" do
          before do
            @adj = PossessiveAdjective.new(
              {:person => 1, :number => :p},
              {:number => :s, :gender => :f}
            )
          end
          it("should return Spanish") { expect(@adj.spanish).to eq 'nuestra' }
          it("should return English") { expect(@adj.english).to eq 'our' }
        end
      end

      context "1st plural owner, pluaral noun: (nuestr-s)" do
        context "masculine noun" do
          before do
            @adj = PossessiveAdjective.new(
              {:person => 1, :number => :p},
              {:number => :p, :gender => :m}
            )
          end
          it("should return Spanish") { expect(@adj.spanish).to eq 'nuestros' }
          it("should return English") { expect(@adj.english).to eq 'our' }
        end
        context "feminine noun" do
          before do
            @adj = PossessiveAdjective.new(
              {:person => 1, :number => :p},
              {:number => :p, :gender => :f}
            )
          end
          it("should return Spanish") { expect(@adj.spanish).to eq 'nuestras' }
          it("should return English") { expect(@adj.english).to eq 'our' }
        end
      end

      context "2nd singular familiar owner, singular noun: (tu)" do
        before do
          @adj = PossessiveAdjective.new(
            {:person => 2, :number => :s, :register => :familiar},
            {:number => :s}
          )
        end
        it("should return Spanish") { expect(@adj.spanish).to eq 'tu' }
        it("should return English") { expect(@adj.english).to eq 'your' }
      end
      context "2nd singular familiar owner, plural noun: (tus)" do
        before do
          @adj = PossessiveAdjective.new(
            {:person => 2, :number => :s, :register => :familiar},
            {:number => :p}
          )
        end
        it("should return Spanish") { expect(@adj.spanish).to eq 'tus' }
        it("should return English") { expect(@adj.english).to eq 'your' }
      end
      context "2nd plural familiar owner, singular noun: (vuestro/a)" do
        context "masculine noun" do
          before do
            @adj = PossessiveAdjective.new(
              {:person => 2, :number => :p, :register => :familiar},
              {:number => :s, :gender => :m}
            )
          end
          it("should return Spanish") { expect(@adj.spanish).to eq 'vuestro' }
          it("should return English") { expect(@adj.english).to eq 'your' }
        end
        context "feminine noun" do
          before do
            @adj = PossessiveAdjective.new(
              {:person => 2, :number => :p, :register => :familiar},
              {:number => :s, :gender => :f}
            )
          end
          it("should return Spanish") { expect(@adj.spanish).to eq 'vuestra' }
          it("should return English") { expect(@adj.english).to eq 'your' }
        end
      end
      context "2nd plural familiar owner, plural noun: (vuestr-s)" do
        context "masculine noun" do
          before do
            @adj = PossessiveAdjective.new(
              {:person => 2, :number => :p, :register => :familiar},
              {:number => :p, :gender => :m}
            )
          end
          it("should return Spanish") { expect(@adj.spanish).to eq 'vuestros' }
          it("should return English") { expect(@adj.english).to eq 'your' }
        end
        context "feminine noun" do
          before do
            @adj = PossessiveAdjective.new(
              {:person => 2, :number => :p, :register => :familiar},
              {:number => :p, :gender => :f}
            )
          end
          it("should return Spanish") { expect(@adj.spanish).to eq 'vuestras' }
          it("should return English") { expect(@adj.english).to eq 'your' }
        end
      end
      context "2nd formal owner, singular noun: (su)" do
        before do
          @adj = PossessiveAdjective.new(
            {:person => 2, :register => :formal},
            {:number => :s}
          )
        end
        it("should return Spanish") { expect(@adj.spanish).to eq 'su' }
        it("should return English") { expect(@adj.english).to eq 'your' }
      end
      context "2nd formal owner, plural noun: (sus)" do
        before do
          @adj = PossessiveAdjective.new(
            {:person => 2, :register => :formal},
            {:number => :p}
          )
        end
        it("should return Spanish") { expect(@adj.spanish).to eq 'sus' }
        it("should return English") { expect(@adj.english).to eq 'your' }
      end

      context "3rd person owner, singular noun: (su)" do
        before do
          @adj = PossessiveAdjective.new(
            {:person => 2, :register => :formal},
            {:number => :s}
          )
        end
        it("should return Spanish") { expect(@adj.spanish).to eq 'su' }
        it("should return English") { expect(@adj.english).to eq 'your' }
      end
      context "3rd person owner, plural noun: (sus)" do
        before do
          @adj = PossessiveAdjective.new(
            {:person => 2, :register => :formal},
            {:number => :p}
          )
        end
        it("should return Spanish") { expect(@adj.spanish).to eq 'sus' }
        it("should return English") { expect(@adj.english).to eq 'your' }
      end

      context "English 3rd person owner" do
        it "should return 'his'" do
          @adj = PossessiveAdjective.new( {:person => 3, :gender => :m, :number => :s}, {})
          expect(@adj.english).to eq 'his'
        end
        it "should return 'her'" do
          @adj = PossessiveAdjective.new( {:person => 3, :gender => :f, :number => :s}, {})
          expect(@adj.english).to eq 'her'
        end
        it "should return 'their'" do
          @adj = PossessiveAdjective.new( {:person => 3, :number => :p }, {})
          expect(@adj.english).to eq 'their'
        end
      end
    end

    describe Noun do
      context "gender" do
        it "should know it's a boy" do
          noun = Noun.new "sistema m system"
          expect(noun.gender).to eq :m
        end
        it "should know it's a girl" do
          noun = Noun.new "pared f wall"
          expect(noun.gender).to eq :f
        end
      end
      context "number" do
        it "should know it's singular" do
          noun = Noun.new("sistema m system", :s)
          expect(noun.number).to eq :s
        end
        it "should know it's plural" do
          noun = Noun.new("pared f wall", :p)
          expect(noun.number).to eq :p
        end
      end
      context "regular Spanish, regular English" do
        context "singular" do
          let( :noun) { Noun.new("libro m book", :s) }
          it "should return a singular Spanish noun" do
            expect(noun.spanish).to eq 'libro'
          end
          it "should return a singular English noun" do
            expect(noun.english).to eq 'book'
          end
        end
        context "plural" do
          let( :noun) { Noun.new("libro m book", :p) }
          it "should pluralize a regular Spanish noun" do
            expect(noun.spanish).to eq 'libros'
          end
          it "should pluralize a regular English noun" do
            expect(noun.english).to eq 'books'
          end
        end
      end
      context "irregular Spanish" do
        it "should return a singular noun" do
          n = Noun.new("lápiz|lápices m pencil", :s)
          expect(n.spanish).to eq 'lápiz'
        end
        it "should return a plural noun" do
          n = Noun.new("lápiz|lápices m pencil", :p)
          expect(n.spanish).to eq 'lápices'
        end
      end
      context "irregular English" do
        it "should return a singular noun" do
          n = Noun.new("patata f potato|potatoes", :s)
          expect(n.english).to eq 'potato'
        end
        it "should return a plural noun" do
          n = Noun.new("patata f potato|potatoes", :p)
          expect(n.english).to eq 'potatoes'
        end
      end
      context "Spanish -es" do
        it "should return a plural noun" do
          n = Noun.new("hospital m hospital", :p)
          expect(n.spanish).to eq 'hospitales'
        end
      end
      context "English -ies" do
        it "should return a plural noun" do
          n = Noun.new("certidumbre m certainty", :p)
          expect(n.english).to eq 'certainties'
        end
      end
    end

    describe DefiniteArticle do
      context "masculine singular" do
        let(:article) { DefiniteArticle.new(:m, :s) }
        it("should return Spanish") { expect(article.spanish).to eq 'el'}
        it("should return English") { expect(article.english).to eq 'the'}
      end

      context "masculine plural" do
        let(:article) { DefiniteArticle.new(:m, :p) }
        it("should return Spanish") { expect(article.spanish).to eq 'los'}
        it("should return English") { expect(article.english).to eq 'the'}
      end

      context "feminine singular" do
        let(:article) { DefiniteArticle.new(:f, :s) }
        it("should return Spanish") { expect(article.spanish).to eq 'la'}
        it("should return English") { expect(article.english).to eq 'the'}
      end

      context "feminine plural" do
        let(:article) { DefiniteArticle.new(:f, :p) }
        it("should return Spanish") { expect(article.spanish).to eq 'las'}
        it("should return English") { expect(article.english).to eq 'the'}
      end

    end
  end
end
