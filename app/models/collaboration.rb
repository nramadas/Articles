class Collaboration < ActiveRecord::Base
  attr_accessible :article_id, :collaborator_id

  belongs_to :article
  belongs_to :collaborator,
             class_name: 'User',
             foreign_key: 'collaborator_id',
             primary_key: 'id'
end
