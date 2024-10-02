# app/services/github_scraper.rb
require 'nokogiri'
require 'httparty'

class GithubScraper
  def initialize(username)
    @username = username
    @url = "https://github.com/#{username}"
  end

  def scrape
    response = HTTParty.get(@url)
    document = Nokogiri::HTML(response.body)
    if response.success?
      {
        github_username: @username,
        followers: extract_followers(document),
        following: extract_following(document),
        stars: extract_stars(document),
        contributions: extract_contributions(document),
        profile_image_url: extract_profile_image(document),
        organization: extract_organization(document),
        location: extract_location(document)
      }
    else
      {}
    end

  end

  private

  def extract_followers(doc)
    followers_text = doc.at_css('a[href*="followers"]')&.text
    parse_number(followers_text) rescue ''
  end

  def extract_following(doc)
    following_text = doc.at_css('a[href*="following"]')&.text
    parse_number(following_text) rescue ''
  end

  def extract_stars(doc)
    stars_text = doc.at_css('a[href*="repositories"]')&.text
    parse_number(stars_text) rescue ''
  end

  def extract_contributions(doc)
    contributions_text = doc.at_css('h2.f4.text-normal.mb-2')&.text
    contributions_text.scan(/\d+/).first.to_i rescue ''
  end

  def extract_profile_image(doc)
    doc.at_css('img.avatar')['src'] rescue ''
  end

  def extract_organization(doc)
    doc.at_css('.p-org')&.text.strip rescue ''
  end

  def extract_location(doc)
    doc.at_css('.p-label')&.text.strip rescue ''
  end

  def parse_number(text)
    text.scan(/\d[\d,]*/).first&.gsub(',', '')&.to_i rescue ''
  end
end
