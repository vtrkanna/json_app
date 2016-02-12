class Contact < ActiveRecord::Base
  belongs_to :user

  scope :accepted, -> { where(status: :accepted) }
  scope :pending, -> { where(status: 'pending') }
  scope :rejected, -> { where(status: :rejected) }

  validates :name, :presence => true, :length => {:minimum => 5}
  validates :email, :presence => true, :uniqueness => false, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  before_save :default_values
  def default_values
    self.status ||= 'pending'
  end

end
