class AddPrivateToSurveys < ActiveRecord::Migration
  def change
  	add_column :surveys, :private, :boolean, default: false
  end
end
