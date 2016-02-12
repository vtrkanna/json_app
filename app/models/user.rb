class User < ActiveRecord::Base
  has_many :contacts
  has_many :pending_contacts, -> { where "contacts.status = 'pending'"}, through: :contacts
  has_many :accepted_contacts, -> { Contact.accepted }, through: :contacts
  has_many :rejected_contacts, -> { Contact.rejected }, through: :contacts

  validates :name, :presence => true, :length => {:minimum => 5}
  validates :password, :presence => true, :length => {:minimum => 6} #, :format => //
  validates :email, :presence => true, :uniqueness => true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
end
