require 'rspec'
require_relative '../deputy_scraper'

RSpec.describe 'Scraping des députés' do
  it 'récupère la liste des députés' do
    deputies = get_all_deputies
    expect(deputies).not_to be_empty
    expect(deputies.length).to be > 0
  end

  it 'récupère le député Jean Durant' do
    deputies = get_all_deputies
    jean_durant = deputies.find { |deputy| deputy['first_name'] == 'Jean' && deputy['last_name'] == 'Durant' }
    expect(jean_durant).not_to be_nil
    expect(jean_durant['email']).to match(/@assemblee.fr/)
  end
end
