require 'nokogiri'

filepath = "output.html"

class Scraper
  def initialize(filename)
    @filename = filename
end

def scrape
  doc = File.open(@filename) { |file| Nokogiri::HTML(file) }

  # .tatvoc, .tatvoc-stopクラスを持つ要素を選択し、.furiganaクラスを持つ要素を除外してテキストを取得
  scraped_text = doc.search(".tatvoc, .tatvoc-stop").reject { |element| element['class'].match?(/\bfurigana\b/) }.map(&:text).join(" ").strip

  # .furiganaクラスに属するテキストを除外
  scraped_text.gsub!(/\p{Han}(?:\p{Hiragana}|\p{Katakana})*\p{Han}/, '')

  puts scraped_text
end
end

scraper = Scraper.new("output.html")
scraper.scrape
