require 'httparty'
require 'nokogiri'

# Récupère l'email d'une mairie à partir de son URL
def get_townhall_email(townhall_url)
  response = HTTParty.get(townhall_url)
  parsed_page = Nokogiri::HTML(response.body)

  email = parsed_page.at('a[href^="mailto:"]').text.strip
  email
end

# Récupère toutes les URLs des mairies du Val d'Oise
def get_townhall_urls
  base_url = "https://lannuaire.service-public.fr/navigation/ile-de-france/val-d-oise/mairie"
  response = HTTParty.get(base_url)
  parsed_page = Nokogiri::HTML(response.body)

  townhall_urls = []
  parsed_page.css('a[href^="http://www."]').each do |link|
    townhall_urls << link['href']
  end

  townhall_urls
end

# Récupère tous les emails des mairies
def get_all_townhall_emails
  townhall_urls = get_townhall_urls
  townhall_emails = []

  townhall_urls.each do |url|
    email = get_townhall_email(url)
    city_name = url.split('/').last.split('.').first
    townhall_emails << { city_name => email }
  end

  townhall_emails
end

if __FILE__ == $PROGRAM_NAME
  puts "Emails des mairies du Val d'Oise :"
  puts get_all_townhall_emails
end
