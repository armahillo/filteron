class User < ApplicationRecord
  # This is basic filtering. It's a naive search / retrieval.
  filter_on "name"

  # This is custom filtering, we provide the scope as a parameter.
  scope :similar_email, ->(email) { where("email LIKE ?", "%#{email}%")}
  filter_on "email", :similar_email
end
