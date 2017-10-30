# module partly based on Paint gem (github.com/janlelis/paint) functionality
# extracted to reduce app dependencies

module Blackjack
  module Painter
    extend self

    EFFECTS = {
      bright: 1,
      underline: 4,
      black: 30,
      red: 31,
      green: 32,
      yellow: 33,
      blue: 34,
      magenta: 35,
      cyan: 36,
      white: 37,
      bg_black: 40,
      bg_red: 41,
      bg_green: 42,
      bg_yellow: 43,
      bg_blue: 44,
      bg_magenta: 45,
      bg_cyan: 46,
      bg_white: 47,
    }

    def [](string, *options)
      return string.to_s if options.empty?

      first_opt = EFFECTS[options[0]]
      second_opt = EFFECTS[options[1]] ? ";#{EFFECTS[options[1]]}" : nil

      "\e[#{first_opt}#{second_opt}m#{string}\e[0m"
    end
  end
end