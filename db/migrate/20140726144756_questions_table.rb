class QuestionsTable < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text
      t.integer :kind
      t.references :survey
      t.timestamps
    end
  end
end

