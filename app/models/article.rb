class Article < ActiveRecord::Base
  attr_accessible :body, :title, :picture

  belongs_to :author,
             class_name: 'User',
             foreign_key: 'author_id'
  has_many :collaborations
  has_many :collaborators, through: :collaborations

  validates_presence_of :body, message: "cannot be blank"
  validates_presence_of :title, message: "cannot be blank"

  validates_length_of :title, maximum: 30, message: "is too long"
end
