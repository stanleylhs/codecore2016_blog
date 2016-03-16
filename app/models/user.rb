# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  email                  :string
#  password_digest        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin                  :boolean          default(FALSE)
#  password_reset_token   :string
#  password_reset_sent_at :datetime
#  last_login_attempt_at  :datetime
#  failed_login_count     :integer
#

class User < ActiveRecord::Base
  has_secure_password

  has_many :posts, dependent: :nullify
  has_many :comments, through: :posts, dependent: :nullify

  has_many :favourites, dependent: :destroy
  has_many :favourited_questions, through: :favourites, source: :question

  validates :password, length: {minimum: 4}, on: :create
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def record_failed_login
    self.last_login_attempt_at = Time.zone.now
    self.failed_login_count += 1
    save!
  end

  def reset_login_attempt_count
    self.failed_login_count = 0
    save!
  end

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    #TODO:
    UserMailer.password_reset(self).deliver_now
  end

  private
  def generate_token(column)
    # never use send with user input!
    # send(column)
    #binding.remote_pry
    # column: self[column] vs column => self[column]
    self[column] = SecureRandom.urlsafe_base64 if User.exists?(column => self[column])
  end

end
