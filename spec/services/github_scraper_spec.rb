require 'rails_helper'
require 'webmock/rspec'

RSpec.describe GithubScraper do
  let(:username) { 'testuser' }
  let(:scraper) { described_class.new(username) }

  before do
    stub_request(:get, "https://github.com/#{username}")
      .to_return(status: 200, body: response_body, headers: {})
  end

  let(:response_body) do
    <<-HTML
      <html>
        <body>
          <a href="/testuser/followers">123 followers</a>
          <a href="/testuser/following">456 following</a>
          <a href="/testuser/repositories">789 repositories</a>
          <h2 class="f4 text-normal mb-2">100 contributions in the last year</h2>
          <img class="avatar" src="http://example.com/avatar.jpg" />
          <div class="p-org">Example Org</div>
          <span class="p-label">Location City</span>
        </body>
      </html>
    HTML
  end

  describe '#scrape' do
    it 'returns user data' do
      result = scraper.scrape

      expect(result).to eq({
        github_username: username,
        followers: 123,
        following: 456,
        stars: 789,
        contributions: 100,
        profile_image_url: 'http://example.com/avatar.jpg',
        organization: 'Example Org',
        location: 'Location City'
      })
    end

    context 'when the response is unsuccessful' do
      before do
        stub_request(:get, "https://github.com/#{username}")
          .to_return(status: 404)
      end

      it 'returns an empty hash' do
        result = scraper.scrape
        expect(result).to eq({})
      end
    end
  end
end
