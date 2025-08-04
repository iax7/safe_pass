class Entry < ApplicationRecord
  belongs_to :user

  validates :name, :username, :password, presence: true
  validate :validate_url

  encrypts :username, deterministic: true
  encrypts :password

  # scope :search_name, ->(name) { where("name ILIKE ?", "%#{name}%") } if name.present? # PostgreSQL
  scope :search_name, ->(name) { where("LOWER(name) LIKE ?", "%#{name&.downcase}%") } if name.present? # SQLite

  def self.search(name)
    search_name(name).order(:name)
  end

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
