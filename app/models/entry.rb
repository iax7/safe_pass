class Entry < ApplicationRecord
  belongs_to :user

  validates :name, :username, :password, presence: true
  validate :validate_url

  encrypts :username, deterministic: true
  encrypts :password

  private

  def validate_url
    uri = URI.parse(url)
    unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
      errors.add(:url, "must be a valid HTTP or HTTPS URL")
    end
  rescue URI::InvalidURIError
    errors.add(:url, "must be a valid URL")
  end
end
