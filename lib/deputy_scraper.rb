require 'httparty'
require 'nokogiri'

# Récupère les URLs de toutes les pages des députés
def get_deputy_urls
  url = "https://www.assemblee-nationale.fr/dyn/15/dep/"
  response = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(response.body)

  deputy_urls = []

  # Sélecteur CSS pour récupérer les liens des députés
  parsed_page.css('a[href^="/dyn/15/dep/"]').each do |link|
    deputy_urls << "https://www.assemblee-nationale.fr#{link['href']}"
  end

  deputy_urls
end

# Récupère les informations d'un député à partir de son URL
def get_deputy_info(deputy_url)
  response = HTTParty.get(deputy_url)
  parsed_page = Nokogiri::HTML(response.body)

  # Extraction du prénom, nom et email
  first_name = parsed_page.at('h1').text.split(' ').first
  last_name = parsed_page.at('h1').text.split(' ').last
  email = parsed_page.at('a[href^="mailto:"]')&.text&.strip

  { "first_name" => first_name, "last_name" => last_name, "email" => email }
end

# Récupère tous les députés avec leurs emails
def get_all_deputies
  deputy_urls = get_deputy_urls
  deputies = []

  deputy_urls.each do |url|
    deputies << get_deputy_info(url)
    
  end
end

# Appel principal pour afficher la liste des députés
if __FILE__ == $0
  deputies = get_all_deputies
  puts "Liste des députés et leurs emails :"
  deputies.each do |deputy|
    puts "#{deputy['first_name']} #{deputy['last_name']} : #{deputy['email']}"
  end
end
