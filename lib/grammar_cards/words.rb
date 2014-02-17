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
      def initialize(data, number=nil)
        fields = data.split(/\s+/)
        @spanish_singular, @spanish_irregular_plural = parse(fields[0])
        @gender = fields[1].to_sym
        @english_singular, @english_irregular_plural = parse(fields[2])
        @number = number
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
          ending = if @spanish_singular =~ /.*[aeiou]$/i
                     's'
                   else
                     'es'
                   end
        "#{@spanish_singular}#{ending}"
      end

      def english_regular_plural
        if @english_singular =~ /.*[^aeiou]y$/i
          @english_singular.sub(/y$/, 'ies')
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
        {:m => 'nuestro', :f => 'nuestra'}[gender]
      end

      def second_person_familiar(number, gender)
        return 'tu' if number == :s
        {:m => 'vuestro', :f => 'vuestra'}[gender]
      end

      def english
        case owner[:person]
        when 1
          {:s => 'my', :p => 'our'}[owner[:number]]
        when 2
          'your'
        when 3
          if owner[:number] == :p
            'their'
          else
            {:m => 'his', :f => 'her'}[owner[:gender]]
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

  end
end
