# encoding: utf-8

module GrammarCards
  module Numbers
    CERO = 'cero'
    CIEN = 'cien'
    MIL = 'mil'

    def spanish_words_for(n)
      if n < 1000
        less_than_1000(n)
      else
        thousand_to_999999(n)
      end
    end

    def equation(op1, op2, operator)
      result = op1.send(operator, op2)
      eq = "#{spanish_words_for(op1)} #{operator_word(operator)} #{spanish_words_for(op2)}"
      eq << " son "
      eq << "menos " if result < 0
      eq << spanish_words_for(result.abs)
    end

    private

    def zero_to_29(n)
      [CERO, 'uno', 'dos', 'tres', 'cuatro', 'cinco', 'seis', 'siete', 'ocho', 'nueve', 'diez',
        'once', 'doce', 'trece', 'catorce', 'quince', 'dieciséis', 'diecisiete', 'dieciocho', 'diecinueve',
        'veinte', 'veintiuno', 'veintidos', 'veintitres', 'veinticuatro', 'veinticinco', 'veintiseis',
        'veintisiete', 'veintiocho', 'veintinueve'][n]
    end

    def by_10(n)
      [CERO, 'diez', 'veinte', 'treinta', 'cuarenta', 'cincuenta', 'sesenta', 'setenta', 'ochenta', 'noventa' ][n]
    end

    def less_than_100(n)
      return zero_to_29(n) if n < 30
      if n % 10 == 0
        by_10(n/10)
      else
        "#{by_10(n / 10)} y #{zero_to_29(n % 10)}"
      end
    end

    def hundred_to_999(n)
      return CIEN if n == 100
      if n % 100 == 0
        by_100(n/100)
      else
        "#{by_100(n / 100)} #{less_than_100(n % 100)}"
      end
    end

    def less_than_1000(n)
      case
      when n < 100
        less_than_100(n)
      when n < 1000
        hundred_to_999(n)
      end
    end

    def thousand_to_999999(n)
      return MIL if n == 1000
      if n < 2000
        thousands = MIL
      else
        thousands = "#{less_than_1000(n / 1000)} #{MIL}"
      end
      if n % 1000 == 0
        thousands
      else
        "#{thousands} #{less_than_1000(n % 1000)}"

      end
    end

    def by_100(n)
      [CERO, 'ciento', 'doscientos', 'trescientos', 'cuatrocientos', 'quinientos',
        'seiscientos', 'setecientos', 'ochocientos', 'novecientos'][n]
    end

    def operator_word(sym)
      {:- => 'menos', :+ => 'más'}[sym]
    end

    extend Numbers
  end
end
