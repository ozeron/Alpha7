class CreateSharedLinks < ActiveRecord::Migration
  def change
    create_table :shared_links do |t|
      t.string :key
      t.references :survey
      t.timestamps
    end
  end
end
