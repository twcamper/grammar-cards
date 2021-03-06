# encoding: utf-8
gem 'psych'
require 'psych'  # YAML implementation
require 'fileutils'

require 'active_support/dependencies/autoload'
require 'active_support/number_helper'
# quiet an ActiveSupport warning
I18n.enforce_available_locales = true

LIB_PATH = File.expand_path('./grammar_cards', File.dirname(__FILE__))

require_relative 'grammar_cards/words'
require_relative 'grammar_cards/verbs'
require_relative 'grammar_cards/numbers'
require_relative 'grammar_cards/syntax'
require_relative 'grammar_cards/annotations'
require_relative 'grammar_cards/characters'
require_relative 'grammar_cards/cards'
require_relative 'grammar_cards/deck'
require_relative 'grammar_cards/text_display'
