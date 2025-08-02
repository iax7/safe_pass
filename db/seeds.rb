# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.find_or_create_by(email: "iax@iax.lol") do |u|
  u.password = "123456"
end

common = { username: user.email, password: "Password123!", user: user }
entries = [
  { name: "GitHub", url: "https://www.github.com/login" },
  { name: "Stack Overflow", url: "https://stackoverflow.com/users/login" },
  { name: "Dribbble", url: "https://dribbble.com/session/new" },
  { name: "Facebook", url: "https://www.facebook.com" },
  { name: "X", url: "https://www.x.com" },
  { name: "Udemy", url: "https://udemy.com/login" },
  { name: "LinkedIn", url: "https://www.linkedin.com" },
  { name: "Instagram", url: "https://www.instagram.com" },
  { name: "Reddit", url: "https://www.reddit.com" },
  { name: "YouTube", url: "https://www.youtube.com" },
  { name: "Amazon", url: "https://www.amazon.com" },
  { name: "Netflix", url: "https://www.netflix.com" },
  { name: "Spotify", url: "https://www.spotify.com" },
  { name: "Slack", url: "https://www.slack.com" },
  { name: "Trello", url: "https://www.trello.com" },
  { name: "Dropbox", url: "https://www.dropbox.com" },
  { name: "Pinterest", url: "https://www.pinterest.com" }
]

entries.each { p Entry.create(_1.merge(common)) }
