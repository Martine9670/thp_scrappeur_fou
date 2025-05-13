require 'rspec'
require_relative '../lib/mairie_scraper'

RSpec.describe 'mairie_scraper' do
  describe '#get_townhall_email' do
    it 'récupère correctement l\'email d\'une mairie' do
      # Exemple d'URL de mairie
      townhall_url = 'http://www.averne.mairie95.fr'
      
      # Appel de la méthode pour récupérer l'email
      email = get_townhall_email(townhall_url)

      # Vérifier que l'email récupéré est correct
      expect(email).to match(/\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/) # Vérification de la validité de l'email
    end
  end

  describe '#get_townhall_urls' do
    it 'récupère correctement les URLs des mairies' do
      townhall_urls = get_townhall_urls

      # Vérifier qu'on a bien des URLs
      expect(townhall_urls).to be_an(Array)
      expect(townhall_urls).to_not be_empty

      # Vérifier qu'une URL est bien formée
      expect(townhall_urls.first).to match(/^http:\/\/www\./)
    end
  end

  describe '#get_all_townhall_emails' do
    it 'récupère correctement tous les emails des mairies' do
      townhall_emails = get_all_townhall_emails

      # Vérifier qu'on a bien un array d'emails
      expect(townhall_emails).to be_an(Array)
      expect(townhall_emails).to_not be_empty

      # Vérifier que chaque élément est un hash avec un nom de ville et un email
      expect(townhall_emails.first).to be_a(Hash)
      expect(townhall_emails.first.keys.first).to be_a(String)
      expect(townhall_emails.first.values.first).to match(/\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/) # Vérification de la validité de l'email
    end
  end
end
