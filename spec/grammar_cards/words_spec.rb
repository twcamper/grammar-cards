# encoding: utf-8
require 'spec_helper'

module GrammarCards
  module Words
    describe PersonalPronoun, "#spanish" do
      context "1st person" do
        it "should return 'yo'" do
          expect(PersonalPronoun.spanish(:per => 1, :num => :s)).to eq 'yo'
        end
        it "should return 'nosotros'" do
          expect(PersonalPronoun.spanish(:per => 1, :num => :p, :gen => :m)).to eq 'nosotros'
        end
        it "should return 'nosotras'" do
          expect(PersonalPronoun.spanish(:per => 1, :num => :p, :gen => :f)).to eq 'nosotras'
        end
      end
      context "2nd person" do
        it "should return 'tú'" do
          expect(PersonalPronoun.spanish(:per => 2, :reg => :familiar, :num => :s)).to eq 'tú'
        end
        it "should return 'vosotros'" do
          expect(PersonalPronoun.spanish(:per => 2, :reg => :familiar, :num => :p, :gen => :m)).to eq 'vosotros'
        end
        it "should return 'vosotras'" do
          expect(PersonalPronoun.spanish(:per => 2, :reg => :familiar, :num => :p, :gen => :f)).to eq 'vosotras'
        end

        it "should return 'Ud.'" do
          expect(PersonalPronoun.spanish(:per => 2, :reg => :formal, :num => :s)).to eq 'Ud.'
        end

        it "should return 'Uds.'" do
          expect(PersonalPronoun.spanish(:per => 2, :reg => :formal, :num => :p)).to eq 'Uds.'
        end
      end

      context "3rd person" do
        it "should return 'él'" do
          expect(PersonalPronoun.spanish(:per => 3,:num => :s,:gen => :m)).to eq 'él'
        end

        it "should return 'ella'" do
          expect(PersonalPronoun.spanish(:per => 3,:num => :s,:gen => :f)).to eq 'ella'
        end

        it "should return 'ellas'" do
          expect(PersonalPronoun.spanish(:per => 3,:num => :p,:gen => :f)).to eq 'ellas'
        end

        it "should return 'ellos'" do
          expect(PersonalPronoun.spanish(:per => 3,:num => :p,:gen => :m)).to eq 'ellos'
        end
      end

    end

    describe PossessiveAdjective do
      context "1st singular owner, singular noun: (mi)" do
        before do
          @adj = PossessiveAdjective.new(
            {:per => 1, :num => :s},
            {:num => :s}
          )
        end
        it("should return Spanish") { expect(@adj.spanish).to eq 'mi' }
        it("should return English") { expect(@adj.english).to eq 'my' }
      end

      context "1st singular owner, pluaral noun: (mis)" do
        before do
          @adj = PossessiveAdjective.new(
            {:per => 1, :num => :s},
            {:num => :p}
          )
        end
        it("should return Spanish") { expect(@adj.spanish).to eq 'mis' }
        it("should return English") { expect(@adj.english).to eq 'my' }
      end

      context "1st plural owner, singular noun: (neustro/a)" do
        context "masculine noun" do
          before do
            @adj = PossessiveAdjective.new(
              {:per => 1, :num => :p},
              {:num => :s, :gen => :m}
            )
          end
          it("should return Spanish") { expect(@adj.spanish).to eq 'nuestro' }
          it("should return English") { expect(@adj.english).to eq 'our' }
        end
        context "feminine noun" do
          before do
            @adj = PossessiveAdjective.new(
              {:per => 1, :num => :p},
              {:num => :s, :gen => :f}
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
              {:per => 1, :num => :p},
              {:num => :p, :gen => :m}
            )
          end
          it("should return Spanish") { expect(@adj.spanish).to eq 'nuestros' }
          it("should return English") { expect(@adj.english).to eq 'our' }
        end
        context "feminine noun" do
          before do
            @adj = PossessiveAdjective.new(
              {:per => 1, :num => :p},
              {:num => :p, :gen => :f}
            )
          end
          it("should return Spanish") { expect(@adj.spanish).to eq 'nuestras' }
          it("should return English") { expect(@adj.english).to eq 'our' }
        end
      end

      context "2nd singular familiar owner, singular noun: (tu)" do
        before do
          @adj = PossessiveAdjective.new(
            {:per => 2, :num => :s, :reg => :familiar},
            {:num => :s}
          )
        end
        it("should return Spanish") { expect(@adj.spanish).to eq 'tu' }
        it("should return English") { expect(@adj.english).to eq 'your' }
      end
      context "2nd singular familiar owner, plural noun: (tus)" do
        before do
          @adj = PossessiveAdjective.new(
            {:per => 2, :num => :s, :reg => :familiar},
            {:num => :p}
          )
        end
        it("should return Spanish") { expect(@adj.spanish).to eq 'tus' }
        it("should return English") { expect(@adj.english).to eq 'your' }
      end
      context "2nd plural familiar owner, singular noun: (vuestro/a)" do
        context "masculine noun" do
          before do
            @adj = PossessiveAdjective.new(
              {:per => 2, :num => :p, :reg => :familiar},
              {:num => :s, :gen => :m}
            )
          end
          it("should return Spanish") { expect(@adj.spanish).to eq 'vuestro' }
          it("should return English") { expect(@adj.english).to eq 'your' }
        end
        context "feminine noun" do
          before do
            @adj = PossessiveAdjective.new(
              {:per => 2, :num => :p, :reg => :familiar},
              {:num => :s, :gen => :f}
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
              {:per => 2, :num => :p, :reg => :familiar},
              {:num => :p, :gen => :m}
            )
          end
          it("should return Spanish") { expect(@adj.spanish).to eq 'vuestros' }
          it("should return English") { expect(@adj.english).to eq 'your' }
        end
        context "feminine noun" do
          before do
            @adj = PossessiveAdjective.new(
              {:per => 2, :num => :p, :reg => :familiar},
              {:num => :p, :gen => :f}
            )
          end
          it("should return Spanish") { expect(@adj.spanish).to eq 'vuestras' }
          it("should return English") { expect(@adj.english).to eq 'your' }
        end
      end
      context "2nd formal owner, singular noun: (su)" do
        before do
          @adj = PossessiveAdjective.new(
            {:per => 2, :reg => :formal},
            {:num => :s}
          )
        end
        it("should return Spanish") { expect(@adj.spanish).to eq 'su' }
        it("should return English") { expect(@adj.english).to eq 'your' }
      end
      context "2nd formal owner, plural noun: (sus)" do
        before do
          @adj = PossessiveAdjective.new(
            {:per => 2, :reg => :formal},
            {:num => :p}
          )
        end
        it("should return Spanish") { expect(@adj.spanish).to eq 'sus' }
        it("should return English") { expect(@adj.english).to eq 'your' }
      end

      context "3rd person owner, singular noun: (su)" do
        before do
          @adj = PossessiveAdjective.new(
            {:per => 2, :reg => :formal},
            {:num => :s}
          )
        end
        it("should return Spanish") { expect(@adj.spanish).to eq 'su' }
        it("should return English") { expect(@adj.english).to eq 'your' }
      end
      context "3rd person owner, plural noun: (sus)" do
        before do
          @adj = PossessiveAdjective.new(
            {:per => 2, :reg => :formal},
            {:num => :p}
          )
        end
        it("should return Spanish") { expect(@adj.spanish).to eq 'sus' }
        it("should return English") { expect(@adj.english).to eq 'your' }
      end

      context "English 3rd person owner" do
        it "should return 'his'" do
          @adj = PossessiveAdjective.new( {:per => 3, :gen => :m, :num => :s}, {})
          expect(@adj.english).to eq 'his'
        end
        it "should return 'her'" do
          @adj = PossessiveAdjective.new( {:per => 3, :gen => :f, :num => :s}, {})
          expect(@adj.english).to eq 'her'
        end
        it "should return 'their'" do
          @adj = PossessiveAdjective.new( {:per => 3, :num => :p }, {})
          expect(@adj.english).to eq 'their'
        end
      end
    end

    describe Noun do
      context "gender" do
        it "should know it's a boy" do
          noun = Noun.new(:esp => "sistema", :gen => :m, :eng => "system")
          expect(noun.gender).to eq :m
        end
        it "should know it's a girl" do
          noun = Noun.new(:esp => "pared", :gen => :f, :eng => "wall")
          expect(noun.gender).to eq :f
        end
      end
      context "number" do
        it "should know it's singular" do
          noun = Noun.new(:esp => "sistema", :gen => :m, :eng => "system", :num => :s)
          expect(noun.number).to eq :s
        end
        it "should know it's plural" do
          noun = Noun.new(:esp => "pared", :gen => :f, :eng => "wall", :num => :p)
          expect(noun.number).to eq :p
        end
      end
      context "regular Spanish, regular English" do
        context "singular" do
          let( :noun) { Noun.new(:esp => "libro", :gen => :m, :eng => "book", :num => :s) }
          it "should return a singular Spanish noun" do
            expect(noun.spanish).to eq 'libro'
          end
          it "should return a singular English noun" do
            expect(noun.english).to eq 'book'
          end
        end
        context "plural" do
          let( :noun) { Noun.new(:esp => "libro", :gen => :m, :eng => "book", :num => :p) }
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
          n = Noun.new(:esp => "lápiz|lápices", :gen => :m, :eng => "pencil", :num => :s)
          expect(n.spanish).to eq 'lápiz'
        end
        it "should return a plural noun" do
          n = Noun.new(:esp => "lápiz|lápices", :gen => :m, :eng => "pencil", :num => :p)
          expect(n.spanish).to eq 'lápices'
        end
      end
      context "irregular English" do
        it "should return a singular noun" do
          n = Noun.new(:esp => "patata", :gen => :f, :eng => "potato|potatoes", :num => :s)
          expect(n.english).to eq 'potato'
        end
        it "should return a plural noun" do
          n = Noun.new(:esp => "patata", :gen => :f, :eng => "potato|potatoes", :num => :p)
          expect(n.english).to eq 'potatoes'
        end
      end
      context "Spanish final accent" do
        it "should return 'sofás'" do
          n = Noun.new(:esp => "sofá", :gen => :m, :eng => "sofa", :num => :p)
          expect(n.spanish).to eq 'sofás'
        end
      end
      context "Spanish -es" do
        it "should return a plural noun" do
          n = Noun.new(:esp => "hospital", :gen => :m, :eng => "hospital", :num => :p)
          expect(n.spanish).to eq 'hospitales'
        end
      end
      context "English -ies" do
        it "should return a plural noun" do
          n = Noun.new(:esp => "certidumbre", :gen => :m, :eng => "certainty", :num => :p)
          expect(n.english).to eq 'certainties'
        end
      end
      context "English -es" do
        it "should return 'taxes'" do
          n = Noun.new(:esp => "impuesto", :gen => :m, :eng => "tax", :num => :p)
          expect(n.english).to eq 'taxes'
        end
        it "should return 'churches'" do
          n = Noun.new(:esp => "iglesia", :gen => :f, :eng => "church", :num => :p)
          expect(n.english).to eq 'churches'
        end
        it "should return 'addresses'" do
          n = Noun.new(:esp => "direccíon", :gen => :f, :eng => "address", :num => :p)
          expect(n.english).to eq 'addresses'
        end
        it "should return 'buzzes'" do
          n = Noun.new(:esp => "zumbido", :gen => :m, :eng => "buzz", :num => :p)
          expect(n.english).to eq 'buzzes'
        end
      end
      context "English -ves" do
        it "should return 'elves'" do
          n = Noun.new(:esp => "elfo", :gen => :f, :eng => "elf", :num => :p)
          expect(n.english).to eq 'elves'
        end
        it "should return 'knives'" do
          n = Noun.new(:esp => "cuchillo", :gen => :m, :eng => "knife", :num => :p)
          expect(n.english).to eq 'knives'
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

    describe RegularVerb do
      describe "#ar" do
        it "should return 'hablo'" do
          expect(RegularVerb.ar("hablar", :per => 1, :num => :s)).to eq 'hablo'
        end
        it "should return 'hablas'" do
          expect(RegularVerb.ar("hablar", :per => 2, :num => :s, :reg => :familiar)).to eq 'hablas'
        end
        it "should return 'habla'" do
          expect(RegularVerb.ar("hablar", :per => 2, :num => :s, :reg => :formal)).to eq 'habla'
          expect(RegularVerb.ar("hablar", :per => 3, :num => :s, :gen => :m)).to eq 'habla'
          expect(RegularVerb.ar("hablar", :per => 3, :num => :s, :gen => :f)).to eq 'habla'
        end

        it "should return 'hablamos'" do
          expect(RegularVerb.ar("hablar", :per => 1, :num => :p)).to eq 'hablamos'
        end
        it "should return 'habláis'" do
          expect(RegularVerb.ar("hablar", :per => 2, :num => :p, :reg => :familiar)).to eq 'habláis'
        end
        it "should return 'hablan'" do
          expect(RegularVerb.ar("hablar", :per => 2, :num => :p, :reg => :formal)).to eq 'hablan'
          expect(RegularVerb.ar("hablar", :per => 3, :num => :p, :gen => :m)).to eq 'hablan'
          expect(RegularVerb.ar("hablar", :per => 3, :num => :p, :gen => :f)).to eq 'hablan'
        end
      end
      describe "#er" do
        it "should return 'como'" do
          expect(RegularVerb.er("comer", :per => 1, :num => :s)).to eq 'como'
        end
        it "should return 'comes'" do
          expect(RegularVerb.er("comer", :per => 2, :num => :s, :reg => :familiar)).to eq 'comes'
        end
        it "should return 'come'" do
          expect(RegularVerb.er("comer", :per => 2, :num => :s, :reg => :formal)).to eq 'come'
          expect(RegularVerb.er("comer", :per => 3, :num => :s, :gen => :m)).to eq 'come'
          expect(RegularVerb.er("comer", :per => 3, :num => :s, :gen => :f)).to eq 'come'
        end

        it "should return 'comemos'" do
          expect(RegularVerb.er("comer", :per => 1, :num => :p)).to eq 'comemos'
        end
        it "should return 'coméis'" do
          expect(RegularVerb.er("comer", :per => 2, :num => :p, :reg => :familiar)).to eq 'coméis'
        end
        it "should return 'comen'" do
          expect(RegularVerb.er("comer", :per => 2, :num => :p, :reg => :formal)).to eq 'comen'
          expect(RegularVerb.er("comer", :per => 3, :num => :p, :gen => :m)).to eq 'comen'
          expect(RegularVerb.er("comer", :per => 3, :num => :p, :gen => :f)).to eq 'comen'
        end
      end
      describe "#ir" do
        it "should return 'vivo'" do
          expect(RegularVerb.ir("vivir", :per => 1, :num => :s)).to eq 'vivo'
        end
        it "should return 'vives'" do
          expect(RegularVerb.ir("vivir", :per => 2, :num => :s, :reg => :familiar)).to eq 'vives'
        end
        it "should return 'vive'" do
          expect(RegularVerb.ir("vivir", :per => 2, :num => :s, :reg => :formal)).to eq 'vive'
          expect(RegularVerb.ir("vivir", :per => 3, :num => :s, :gen => :m)).to eq 'vive'
          expect(RegularVerb.ir("vivir", :per => 3, :num => :s, :gen => :f)).to eq 'vive'
        end

        it "should return 'vivemos'" do
          expect(RegularVerb.ir("vivir", :per => 1, :num => :p)).to eq 'vivimos'
        end
        it "should return 'vivís'" do
          expect(RegularVerb.ir("vivir", :per => 2, :num => :p, :reg => :familiar)).to eq 'vivís'
        end
        it "should return 'viven'" do
          expect(RegularVerb.ir("vivir", :per => 2, :num => :p, :reg => :formal)).to eq 'viven'
          expect(RegularVerb.ir("vivir", :per => 3, :num => :p, :gen => :m)).to eq 'viven'
          expect(RegularVerb.ir("vivir", :per => 3, :num => :p, :gen => :f)).to eq 'viven'
        end
      end
    end
  end
end
