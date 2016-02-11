class Contact < ActiveRecord::Base
  belongs_to :user
  validates :name, :presence => true, :length => {:minimum => 5}
  validates :email, :presence => true, :uniqueness => false, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

end
