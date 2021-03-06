class User < ActiveRecord::Base

  include BCrypt
  has_many :posts
  validates :password, presence: true
  validates :password, format: {with: /\S{3,}/}
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: {with: /\S{3,}@\S{3,}\.\S{2,}/}


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return user if user && user.password == password
    return nil
  end

end