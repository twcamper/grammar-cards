# encoding: utf-8

module GrammarCards
  module Annotations

    def disambiguate_owner(owner)
      case owner[:person]
      when 2
        raise 'register required for 2nd person' unless owner[:register]
        {:s => 'singular', :p => 'plural'}[owner[:number]] + " " + owner[:register].to_s
      when 3
        if owner[:number] == :p
          raise 'gender required for 3rd person plural' unless owner[:gender]
          owner[:gender].to_s
        end
      end
    end
    extend Annotations
  end
end
