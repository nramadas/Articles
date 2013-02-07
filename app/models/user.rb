class User < ActiveRecord::Base
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password

  attr_accessible :email, :name, :password, :password_confirmation,
                  :session_token

  has_many :authored_articles,
           class_name: 'Article',
           foreign_key: 'author_id'
  has_many :collaborations,
           foreign_key: 'collaborator_id',
           primary_key: 'id'
  has_many :contributed_articles,
           through: :collaborations,
           source: :article

  validates_presence_of   :name, message: "cannot be blank"

  validates_presence_of   :email, message: "cannot be blank"
  validates_uniqueness_of :email, case_sensitive: false,
                                  message: "already taken"
  validates_format_of     :email, with: EMAIL_REGEX, message: "must be valid"

  validates_presence_of   :password_confirmation, if: :check_confirmation?,
                                  message: "cannot be blank"
  validates_length_of     :password, minimum: 8, on: :create,
                                  message: "must be atleast 8 characters long"


  def check_confirmation?
    password
  end
end
