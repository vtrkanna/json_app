class User < ActiveRecord::Base
  has_many :contacts
  validates :name, :presence => true, :length => {:minimum => 5}
  validates :password, :presence => true, :length => {:minimum => 6} #, :format => //
  validates :email, :presence => true, :uniqueness => true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
end
