class AddPhotoToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :picture, :binary
  end
end
