# encoding: utf-8
gem 'psych'
require 'psych'  # YAML implementation
require 'fileutils'

require 'active_support/number_helper'
# quiet an ActiveSupport warning
I18n.enforce_available_locales = true

require_relative 'grammar_cards/words'
require_relative 'grammar_cards/numbers'
require_relative 'grammar_cards/syntax'
require_relative 'grammar_cards/annotations'
require_relative 'grammar_cards/cards'
require_relative 'grammar_cards/deck'
require_relative 'grammar_cards/text_display'
