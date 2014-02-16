# encoding: utf-8
module GrammarCards

  module Possessive
    module Adjective

      def build(owner, owned)
        stem = if owner[:person] == 1
                 first_person(owner[:number], owned[:gender])
               elsif owner[:person] == 2 && owner[:register] == :familiar
                 second_person_familiar(owner[:number], owned[:gender])
               else
                 'su'
               end

        owned[:number] == :s ? stem : "#{stem}s"
      end

      def first_person(number, gender)
        return 'mi' if number == :s
        gender == :m ? 'nuestro' : 'nuestra'
      end

      def second_person_familiar(number, gender)
        return 'tu' if number == :s
        gender == :m ? 'vuestro' : 'vuestra'
      end

      extend Adjective
    end
  end

  module Possessive
    module Pronoun

      def pronoun(person, number, gender)
        if person == 2
          {:s => 'Ud.', :p => 'Uds.'}[number]
        else
          {:s => {:m => 'él', :f => 'ella'},
           :p => {:m => 'ellos', :f => 'ellas'}}[number][gender]
        end
      end

      def build(owner)
        "de #{pronoun(owner[:person], owner[:number], owner[:gender])}"
      end
      extend Pronoun
    end
  end
end
