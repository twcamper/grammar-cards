# encoding: utf-8
require 'spec_helper'

module GrammarCards
  module Words
    describe PersonalPronoun do
      describe "#random_pronoun_for" do
        it "it should return 'yo' for 0" do
          expect(PersonalPronoun.random_pronoun_for(0)).to eq 'yo'
        end
        it "it should return 'nosotros' or 'nosotras' for 1" do
          expect(PersonalPronoun.random_pronoun_for(1)).to match /^nosotr[oa]s$/
        end
        it "it should return 'tú' for 2" do
          expect(PersonalPronoun.random_pronoun_for(2)).to eq 'tú'
        end
        it "it should return 'vosotros' or 'vosotras' for 3" do
          expect(PersonalPronoun.random_pronoun_for(3)).to match /^vosotr[oa]s$/
        end
        it "it should return 'él' or 'ella' or 'Ud.' for 4" do
          expect(PersonalPronoun.random_pronoun_for(4)).to match /^(él|ella|Ud\.)$/
        end
        it "it should return 'ellos' or 'ellas' or 'Uds.' for 5" do
          expect(PersonalPronoun.random_pronoun_for(5)).to match /^(ellos|ellas|Uds\.)$/
        end
      end
      describe "#spanish" do
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
      describe "#verb_form_for" do
        it "should return 0" do
          expect(RegularVerb.verb_form_for('yo')).to eq 0
        end
        it "should return 1" do
          expect(RegularVerb.verb_form_for('nosotros')).to eq 1
          expect(RegularVerb.verb_form_for('nosotras')).to eq 1
        end
        it "should return 2" do
          expect(RegularVerb.verb_form_for('tú')).to eq 2
        end

        it "should return 3" do
          expect(RegularVerb.verb_form_for('vosotros')).to eq 3
          expect(RegularVerb.verb_form_for('vosotras')).to eq 3
        end
        it "should return 4" do
          expect(RegularVerb.verb_form_for('él')).to eq 4
          expect(RegularVerb.verb_form_for('ella')).to eq 4
          expect(RegularVerb.verb_form_for('Ud.')).to eq 4
          expect(RegularVerb.verb_form_for('Usted')).to eq 4
          expect(RegularVerb.verb_form_for('él/ella/Ud.')).to eq 4
        end
        it "should return 5" do
          expect(RegularVerb.verb_form_for('ellos')).to eq 5
          expect(RegularVerb.verb_form_for('ellas')).to eq 5
          expect(RegularVerb.verb_form_for('Uds.')).to eq 5
          expect(RegularVerb.verb_form_for('Ustedes')).to eq 5
          expect(RegularVerb.verb_form_for('ellos/ellas/Uds.')).to eq 5
        end
      end
      describe "#spanish" do
        context "verb form number input" do
          it "should return 'escribimos' for 1" do
            expect(RegularVerb.spanish("escribir", 1)).to eq 'escribimos'
          end
        end
        context "pronoun input" do
          context "ar" do
            it "should return 'hablo'" do
              expect(RegularVerb.spanish("hablar", 'yo')).to eq 'hablo'
            end
            it "should return 'hablas'" do
              expect(RegularVerb.spanish("hablar", 'tú')).to eq 'hablas'
            end
            it "should return 'habla'" do
              expect(RegularVerb.spanish("hablar", 'él')).to eq 'habla'
              expect(RegularVerb.spanish("hablar", 'ella')).to eq 'habla'
              expect(RegularVerb.spanish("hablar", 'Ud.')).to eq 'habla'
            end

            it "should return 'hablamos'" do
              expect(RegularVerb.spanish("hablar", 'nosotros')).to eq 'hablamos'
              expect(RegularVerb.spanish("hablar", 'nosotras')).to eq 'hablamos'
            end
            it "should return 'habláis'" do
              expect(RegularVerb.spanish("hablar", 'vosotros')).to eq 'habláis'
              expect(RegularVerb.spanish("hablar", 'vosotras')).to eq 'habláis'
            end
            it "should return 'hablan'" do
              expect(RegularVerb.spanish("hablar", 'ellos')).to eq 'hablan'
              expect(RegularVerb.spanish("hablar", 'ellas')).to eq 'hablan'
              expect(RegularVerb.spanish("hablar", 'Uds.')).to eq 'hablan'
            end
          end
          context "er" do
            it "should return 'como'" do
              expect(RegularVerb.spanish("comer", 'yo')).to eq 'como'
            end
            it "should return 'comes'" do
              expect(RegularVerb.spanish("comer", 'tú')).to eq 'comes'
            end
            it "should return 'come'" do
              expect(RegularVerb.spanish("comer", 'él')).to eq 'come'
              expect(RegularVerb.spanish("comer", 'ella')).to eq 'come'
              expect(RegularVerb.spanish("comer", 'Ud.')).to eq 'come'
            end

            it "should return 'comemos'" do
              expect(RegularVerb.spanish("comer", 'nosotros')).to eq 'comemos'
              expect(RegularVerb.spanish("comer", 'nosotras')).to eq 'comemos'
            end
            it "should return 'coméis'" do
              expect(RegularVerb.spanish("comer", 'vosotros')).to eq 'coméis'
              expect(RegularVerb.spanish("comer", 'vosotras')).to eq 'coméis'
            end
            it "should return 'comen'" do
              expect(RegularVerb.spanish("comer", 'ellos')).to eq 'comen'
              expect(RegularVerb.spanish("comer", 'ellas')).to eq 'comen'
              expect(RegularVerb.spanish("comer", 'Uds.')).to eq 'comen'
            end
          end
          context "ir" do
            it "should return 'vivo'" do
              expect(RegularVerb.spanish("vivir", 'yo')).to eq 'vivo'
            end
            it "should return 'vives'" do
              expect(RegularVerb.spanish("vivir", 'tú')).to eq 'vives'
            end
            it "should return 'vive'" do
              expect(RegularVerb.spanish("vivir", 'él')).to eq 'vive'
              expect(RegularVerb.spanish("vivir", 'ella')).to eq 'vive'
              expect(RegularVerb.spanish("vivir", 'Ud.')).to eq 'vive'
            end

            it "should return 'vivemos'" do
              expect(RegularVerb.spanish("vivir", 'nosotros')).to eq 'vivimos'
              expect(RegularVerb.spanish("vivir", 'nosotras')).to eq 'vivimos'
            end
            it "should return 'vivís'" do
              expect(RegularVerb.spanish("vivir", 'vosotros')).to eq 'vivís'
              expect(RegularVerb.spanish("vivir", 'vosotras')).to eq 'vivís'
            end
            it "should return 'viven'" do
              expect(RegularVerb.spanish("vivir", 'ellos')).to eq 'viven'
              expect(RegularVerb.spanish("vivir", 'ellas')).to eq 'viven'
              expect(RegularVerb.spanish("vivir", 'Uds.')).to eq 'viven'
            end
          end
        end
      end
    end
  end
end
