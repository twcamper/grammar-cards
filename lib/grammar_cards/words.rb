# encoding: utf-8
module GrammarCards
  module Words
    class DefiniteArticle
      attr_reader :english

      def initialize(gender, number)
        @english = 'the'
        @gender = gender
        @number = number
      end

      def spanish
        {:m => {:s => 'el', :p =>'los'},
         :f =>{:s => 'la', :p => 'las'}}[@gender][@number]
      end
    end

    class Noun

      attr_reader :gender
      attr_accessor :number
      def initialize(attrs)
        @spanish_singular, @spanish_irregular_plural = parse(attrs[:esp])
        @gender = attrs[:gen]
        @english_singular, @english_irregular_plural = parse(attrs[:eng])
        @number = attrs[:num]
      end

      def spanish
        if @number == :p
          @spanish_irregular_plural || spanish_regular_plural
        else
          @spanish_singular
        end
      end

      def english
        if @number == :p
          @english_irregular_plural || english_regular_plural
        else
          @english_singular
        end
      end

      private
      def parse(s)
        s.split("|")
      end

      def spanish_regular_plural
          ending = if @spanish_singular =~ /.*[áaeiou]$/i
                     's'
                   else
                     'es'
                   end
        "#{@spanish_singular}#{ending}"
      end

      def english_regular_plural
        case @english_singular
        when /.*[^aeiou]y$/i
          @english_singular.sub(/y$/, 'ies')
        when /.*(x|ch|s|z)$/
          @english_singular + "es"
        when /.*fe?$/
          @english_singular.sub(/fe?$/, 'ves')
        else
          "#{@english_singular}s"
        end
      end

    end
    class PossessiveAdjective

      def initialize(owner, owned)
        @owner = owner
        @owned = owned
      end

      attr_reader :owner, :owned

      def spanish
        stem = if owner[:per] == 1
                 first_person(owner[:num], owned[:gen])
               elsif owner[:per] == 2 && owner[:reg] == :familiar
                 second_person_familiar(owner[:num], owned[:gen])
               else
                 'su'
               end

        owned[:num] == :s ? stem : "#{stem}s"
      end

      def first_person(number, gender)
        return 'mi' if number == :s
        {:m => 'nuestro', :f => 'nuestra'}[gender]
      end

      def second_person_familiar(number, gender)
        return 'tu' if number == :s
        {:m => 'vuestro', :f => 'vuestra'}[gender]
      end

      def english
        case owner[:per]
        when 1
          {:s => 'my', :p => 'our'}[owner[:num]]
        when 2
          'your'
        when 3
          if owner[:num] == :p
            'their'
          else
            {:m => 'his', :f => 'her'}[owner[:gen]]
          end
        end
      end

    end
    module PossessivePronoun
      def spanish(person, number, gender=nil)
        if person == 2
          {:s => 'Ud.', :p => 'Uds.'}[number]
        else
          {:s => {:m => 'él', :f => 'ella'},
           :p => {:m => 'ellos', :f => 'ellas'}}[number][gender]
        end
      end

      extend PossessivePronoun
    end

    module RegularVerb
      def ar(esp, subject)
        ending = case subject[:per]
        when 1
          {:s => 'o', :p => 'amos'}[subject[:num]]
        when 2
          {:s => {:familiar => 'as', :formal => 'a'},
           :p => {:familiar => 'áis', :formal => 'an'}}[subject[:num]][subject[:reg]]
        when 3
          {:s => 'a', :p => 'an'}[subject[:num]]
        end

        esp.sub(/ar$/, ending)
      end
      def er(esp, subject)
        ending = case subject[:per]
        when 1
          {:s => 'o', :p => 'emos'}[subject[:num]]
        when 2
          {:s => {:familiar => 'es', :formal => 'e'},
           :p => {:familiar => 'éis', :formal => 'en'}}[subject[:num]][subject[:reg]]
        when 3
          {:s => 'e', :p => 'en'}[subject[:num]]
        end

        esp.sub(/er$/, ending)
      end
      def ir(esp, subject)
        ending = case subject[:per]
        when 1
          {:s => 'o', :p => 'imos'}[subject[:num]]
        when 2
          {:s => {:familiar => 'es', :formal => 'e'},
           :p => {:familiar => 'ís', :formal => 'en'}}[subject[:num]][subject[:reg]]
        when 3
          {:s => 'e', :p => 'en'}[subject[:num]]
        end

        esp.sub(/ir$/, ending)
      end
      extend RegularVerb
    end
  end
end
