require 'spec_helper'
require_relative '../lib/dark_trader'

RSpec.describe DarkTrader do
  describe '.fetch_prices' do
    it 'retourne un tableau de hachages avec les noms et les prix des cryptomonnaies' do
      result = DarkTrader.fetch_prices
      expect(result).to be_an(Array)
      expect(result.first).to be_a(Hash)
      expect(result.first.keys.first).to be_a(String)
      expect(result.first.values.first).to be_a(Float)
    end
  end
end