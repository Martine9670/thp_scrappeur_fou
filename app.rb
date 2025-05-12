require_relative './lib/crypto_scraper'

scraper = CryptoScraper.new
cryptos = scraper.fetch_prices
puts "\n=> Résultat final :"
p cryptos.first(10) # Affiche les 10 premières cryptos pour vérification


require_relative './lib/mairie_scraper'

scraper = MairieScraper.new
result = scraper.get_townhall_emails

puts "\n--- Résultat final (extrait) ---"
puts result.first(10).inspect
