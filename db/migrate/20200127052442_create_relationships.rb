class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
    	t.references :user, foreign_key: true
    	t.references :followed, foreign_key: {to_table: :users}

    	t.index [:user_id, :followed_id], unique: true


      t.timestamps null: false
    end
  end
end
