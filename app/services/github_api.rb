require 'httparty'

class GitHubAPI
  include HTTParty
  base_uri ENV["BASE_URL"]

  def initialize
    @options = {
      query: {
        client_id: ENV["CLIENT_ID"],
        client_secret: ENV["CLIENT_SECRET"]
      }
    }
  end

  def get_user(username)
    self.class.get("/#{username}", @options)
  end
end
