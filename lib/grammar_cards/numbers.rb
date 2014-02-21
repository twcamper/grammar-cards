# encoding: utf-8
module GrammarCards
  module Numbers
    CERO, UNO, DOS, TRES, CUATRO, CINCO = 'cero', 'uno', 'dos', 'tres', 'cuatro','cinco'
    SEIS, SIETE, OCHO, NUEVE, DIEZ = 'seis', 'siete', 'ocho', 'nueve', 'diez'
    ONCE, DOCE, TRECE, CATORCE, QUINCE = 'once', 'doce', 'trece', 'catorce', 'quince'
    DIECISEIS, DIECISIETE, DIECIOCHO, DIECINUEVE = 'dieciséis', 'diecisiete', 'dieciocho', 'diecinueve'
    VEINTE       = 'veinte'
    VEINTIUNO    = 'veinti' + UNO
    VEINTIDOS    = 'veinti' + DOS
    VEINTITRES   = 'veinti' + TRES
    VEINTICUATRO = 'veinti' + CUATRO
    VEINTICINCO  = 'veinti' + CINCO
    VEINTISEIS   = 'veinti' + SEIS
    VEINTISIETE  = 'veinti' + SIETE
    VEINTIOCHO   = 'veinti' + OCHO
    VEINTINUEVE  = 'veinti' + NUEVE
    TREINTA, CUARENTA, CINCUENTA, SEISENTA, SETENTA, OCHENTA, NOVENTA = 'treinta', 'cuarenta', 'cincuenta', 'sesenta', 'setenta', 'ochenta', 'noventa'
    CIEN, CIENTO = 'cien', 'ciento'
    DOSCIENTOS, TRESCIENTOS, CUATROCIENTOS, QUINIENTOS = 'doscientos', 'trescientos', 'cuatrocientos', 'quinientos'
    SEISCIENTOS, SETECIENTOS, OCHOCIENTOS, NOVECIENTOS = 'seiscientos', 'setecientos', 'ochocientos', 'novecientos'
    MIL = 'mil'

    def spanish_words_for(n)
      if n < 1000
        less_than_1000(n)
      else
        thousand_to_999999(n)
      end
    end

    def zero_to_29(n)
      [CERO, UNO, DOS, TRES, CUATRO, CINCO, SEIS, SIETE, OCHO, NUEVE, DIEZ,
        ONCE, DOCE, TRECE, CATORCE, QUINCE, DIECISEIS, DIECISIETE, DIECIOCHO, DIECINUEVE,
        VEINTE, VEINTIUNO, VEINTIDOS, VEINTITRES, VEINTICUATRO, VEINTICINCO, VEINTISEIS,
        VEINTISIETE, VEINTIOCHO, VEINTINUEVE][n]
    end

    def by_10(n)
      [CERO, DIEZ, VEINTE, TREINTA, CUARENTA, CINCUENTA, SEISENTA, SETENTA, OCHENTA, NOVENTA ][n]
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
      thousands = "#{less_than_1000(n / 1000)} #{MIL}"
      if n % 1000 == 0
        thousands
      else
        "#{thousands} #{less_than_1000(n % 1000)}"

      end
    end

    def by_100(n)
      [CERO, CIENTO, DOSCIENTOS, TRESCIENTOS, CUATROCIENTOS, QUINIENTOS,
        SEISCIENTOS, SETECIENTOS, OCHOCIENTOS, NOVECIENTOS][n]
    end
    extend Numbers
  end
end
