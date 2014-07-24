class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.string :text
      t.references :question
      t.timestamps
    end
  end
end
