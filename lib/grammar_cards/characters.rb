# encoding: utf-8

module GrammarCards
  module Characters

    def disambiguate_owner(owner)
      list = case owner[:per]
      when 2
        raise 'register required for 2nd person' unless owner[:reg]
        second_person_characters[owner[:num]][owner[:reg]]
      when 3
        if owner[:num] == :p
          raise 'gender required for 3rd person plural' unless owner[:gen]
          third_person_plural_characters[owner[:gen]]
        end
      end
      list[rand(list.size)] if list
    end

    def third_person_plural_characters
      {:m => ['los amigos', 'los caballeros', 'unos estudiantes', 'los mariachis', 'unos fútbolistas', 'los niños'],
       :f => ['unas amigas', 'Barabara y Lidia', 'las abuelitas', 'las profesoras', 'las niñas', 'unas estudiantes',
          'las socias', 'unas mujeres', 'las señoras']
      }
    end

    def second_person_characters
      {:s => {:familiar => ['la novia', 'el amigo', 'una muchacha', 'un niñito', 'una niñita', 'el hermanito', 'un primo'],
              :formal   => ['el policîa', 'la doctora', 'el juez', 'el cliente', 'administrador', 'un diplomatico']},
       :p => {:familiar => ['unos muchachos', 'niños', 'primos', 'hermanas', 'unas niñitas', 'colegas', 'amigas'],
              :formal   => ['el tribunal', 'los clientes', 'unos doctores', 'unas diplomáticas', 'un congreso distinguido', 'los oficiales'] }}
    end

    extend Characters
  end
end
