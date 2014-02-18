# encoding: utf-8

module GrammarCards
  module Annotations

    def disambiguate_owner(owner)
      case owner[:per]
      when 2
        raise 'register required for 2nd person' unless owner[:reg]
        {:s => 'singular', :p => 'plural'}[owner[:num]] + " " + owner[:reg].to_s
      when 3
        if owner[:num] == :p
          raise 'gender required for 3rd person plural' unless owner[:gen]
          owner[:gen].to_s
        end
      end
    end
    extend Annotations
  end
end
