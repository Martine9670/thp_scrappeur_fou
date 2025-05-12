require 'nokogiri'
require 'open-uri'

class MairieScraper
  BASE_URL = "https://www.annuaire-des-mairies.com"

  # 1. Récupère l'e-mail depuis une page de mairie
  def get_townhall_email(townhall_url)
    page = Nokogiri::HTML(URI.open(townhall_url))
    email = page.xpath('//td[contains(text(), "@")]').text.strip
    email
  rescue
    nil
  end

  # 2. Récupère toutes les URLs des mairies du Val d'Oise
  def get_townhall_urls
    index_url = "#{BASE_URL}/val-d-oise.html"
    page = Nokogiri::HTML(URI.open(index_url))

    urls = page.css('a.lientxt').map do |link|
      name = link.text.strip
      path = link['href'].sub('./', '')
      { name => "#{BASE_URL}/#{path}" }
    end

    urls
  end

  # 3. Combine tout pour obtenir un array de hash { "ville" => "email" }
  def get_townhall_emails
    puts "Récupération des URLs..."
    townhall_urls = get_townhall_urls

    puts "Scraping des e-mails..."
    townhall_urls.map.with_index do |hash, i|
      name, url = hash.first
      email = get_townhall_email(url)
      puts "#{i + 1}. #{name} => #{email}"
      { name => email }
    end
  end
end