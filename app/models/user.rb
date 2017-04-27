require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]}
  validates :email, presence: true
  has_many :sender_matches, class_name: 'Match', dependent: :destroy, foreign_key: :sender_id
  has_many :receiver_matches, class_name: 'Match', dependent: :destroy, foreign_key: :receiver_id
  has_many :senders, through: :sender_matches
  has_many :receivers, through: :receiver_matches

  def password
    @password ||= Password.new(password_hash) if password_hash
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def matches
     matches = []
     matches.add(Matches.where(sender_id: current_user.id))
  end
end
