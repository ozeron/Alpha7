class AnswerTable < ActiveRecord::Migration
  def change
     create_table :answers do |t|
       t.text :text
       t.references :question
       t.references :answerer

       t.timestamps
     end
  end
end
