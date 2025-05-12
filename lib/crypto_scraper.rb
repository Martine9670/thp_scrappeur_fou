require 'nokogiri'
require 'open-uri'

class CryptoScraper
  URL = 'https://coinmarketcap.com/'

  def fetch_prices
    puts "Connexion à #{URL}..."
    html = URI.open(URL)
    doc = Nokogiri::HTML(html)

    cryptos_array = []

    rows = doc.css('table.cmc-table tbody tr')
    puts "Nombre de lignes récupérées : #{rows.size}"

    rows.each_with_index do |row, index|
      symbol = row.css('td:nth-child(3) div').text.strip
      price_str = row.css('td:nth-child(4)').text.strip.gsub(/[^0-9\.,]/, '').gsub(',', '')

      begin
        price = price_str.to_f
        cryptos_array << { symbol => price }
        puts "#{index + 1}. #{symbol} => $#{price}"
      rescue => e
        puts "Erreur lors du parsing pour #{symbol}: #{e.message}"
      end
    end

    cryptos_array
  end
end