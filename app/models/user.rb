class User < ApplicationRecord
  
  def self.ransackable_attributes(auth_object = nil)
    ["address_web", "contributions", "created_at", "followers", "following", "github_username", "id", "id_value", "location", "name", "organization", "profile_image_url", "stars", "updated_at"]
  end
end
