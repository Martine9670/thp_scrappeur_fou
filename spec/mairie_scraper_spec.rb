require_relative '../lib/mairie_scraper'

RSpec.describe MairieScraper do
  let(:scraper) { MairieScraper.new }

  describe "#get_townhall_email" do
    it "renvoie une adresse email valide pour une mairie" do
      url = "https://www.annuaire-des-mairies.com/95/avernes.html"
      email = scraper.get_townhall_email(url)
      expect(email).to match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
    end
  end

  describe "#get_townhall_urls" do
    it "renvoie une liste de villes avec leur URL" do
      urls = scraper.get_townhall_urls
      expect(urls).not_to be_empty
      expect(urls.first.keys.first).to be_a(String)
      expect(urls.first.values.first).to match(/^https:\/\/www\.annuaire-des-mairies\.com\/\S+\.html$/)
    end
  end

  describe "#get_townhall_emails" do
    it "renvoie un array de hash contenant des noms de ville et emails" do
      emails = scraper.get_townhall_emails
      expect(emails).not_to be_empty
      expect(emails.first).to be_a(Hash)
      expect(emails.first.keys.first).to be_a(String)
    end
  end
end