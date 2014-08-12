class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :survey
      t.references :answerer
      t.timestamps
    end
    remove_column :answers, :answerer_id, :integer
    add_column :answers, :response_id, :integer
  end
end
