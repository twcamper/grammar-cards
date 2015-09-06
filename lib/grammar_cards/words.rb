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
         :f => {:s => 'la', :p => 'las'},
         :f_el => {:s => 'el', :p => 'las'}}[@gender][@number]
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
    module PersonalPronoun
      def spanish(noun)
        pp = case noun[:per]
        when 1
          {:s => 'yo', :p => 'nosotros'}[noun[:num]]
        when 2
          raise 'register required for 2nd person' unless noun[:reg]
          {:formal => {:s => 'Ud.', :p => 'Uds.'},
           :familiar => {:s => 'tú', :p => 'vosotros'}}[noun[:reg]][noun[:num]]
        when 3
          {:s => {:m => 'él', :f => 'ella'},
           :p => {:m => 'ellos', :f => 'ellas'}}[noun[:num]][noun[:gen]]
        end
        if pp =~ /osotros$/ && noun[:gen] == :f
          pp.sub!(/os$/, 'as')
        end
        pp
      end

      def random_pronoun_for(verb_form)
        case verb_form
        when :s1
          'yo'
        when :p1
          ['nosotros', 'nosotras'][rand(2)]
        when :s2
          'tú'
        when :p2
          ['vosotros', 'vosotras'][rand(2)]
        when :s3
          ['él', 'ella', 'Ud.'][rand(3)]
        when :p3
          ['ellos', 'ellas', 'Uds.'][rand(3)]
        else
          raise "invalid verb form number #{verb_form}"
        end
      end

      extend PersonalPronoun
    end

  end
end
