# frozen_string_literal: true

COLOR_THEMES = {
  gray: {
    bg: 'bg-gray-200',
    text: 'text-black',
    hover: 'hover:bg-gray-300',
    focus: 'focus:ring-gray-500 focus:ring-offset-gray-200'
  },
  slate: {
    bg: 'bg-slate-600',
    text: 'text-white',
    hover: 'hover:bg-slate-700',
    focus: 'focus:ring-slate-500 focus:ring-offset-slate-200'
  },
  blue: {
    bg: 'bg-blue-600',
    text: 'text-white',
    hover: 'hover:bg-blue-700',
    focus: 'focus:ring-blue-500 focus:ring-offset-blue-200'
  },
  green: {
    bg: 'bg-green-600',
    text: 'text-white',
    hover: 'hover:bg-green-700',
    focus: 'focus:ring-green-500 focus:ring-offset-green-200'
  },
  red: {
    bg: 'bg-gray-100',
    text: 'text-red-600 font-bold',
    hover: 'hover:bg-red-300',
    focus: 'focus:ring-red-500 focus:ring-offset-red-200'
  }
}.freeze

module ThemesHelper
  def button_css(color)
    raise "'#{color}' is not a valid color theme." unless COLOR_THEMES[color]

    theme_styles = COLOR_THEMES[color].map { |_, v| v }.join(' ')
    focus = 'focus:outline-none focus:ring-2'
    animation = 'transition ease-in duration-100'
    shape = 'rounded-lg py-2 px-4'
    "#{shape} #{animation} #{focus} #{theme_styles} cursor-pointer text-base leading-5"
  end
end
