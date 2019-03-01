class User < ApplicationRecord
  filter_on "name"

  scope :similar_email, ->(email) { where("email LIKE ?", "%#{email}%")}
  filter_on "email", :similar_email
end
