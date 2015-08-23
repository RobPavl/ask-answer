class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true, foreign_key: true
      t.string :body
      t.string :commentable_type
      t.integer :commentable_id
      t.timestamps null: false
    end
    add_index :comments, [:commentable_id, :commentable_type, :user_id], name: :user_polymorphic_comment
  end
end
