class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.integer :collaborator_id
      t.integer :article_id

      t.timestamps
    end
  end
end
