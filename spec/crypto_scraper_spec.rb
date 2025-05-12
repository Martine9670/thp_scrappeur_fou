require_relative '../lib/crypto_scraper'

RSpec.describe CryptoScraper do
  let(:scraper) { CryptoScraper.new }
  let(:result) { scraper.fetch_prices }

  it "renvoie un array non vide" do
    expect(result).not_to be_empty
  end

  it "contient des hashes avec symboles de cryptos et prix" do
    expect(result).to all(be_a(Hash))
    expect(result.first.keys.first).to be_a(String)
    expect(result.first.values.first).to be_a(Float)
  end

  it "contient au moins le BTC ou ETH" do
    symbols = result.map(&:keys).flatten
    expect(symbols).to include("BTC").or include("ETH")
  end
end