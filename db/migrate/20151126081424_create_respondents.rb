class CreateRespondents < ActiveRecord::Migration
  def change
    create_table :respondents do |t|
      t.string :email
      t.boolean :distributed
      t.boolean :answered
      t.references :distribution

      t.timestamps null: false
    end
  end
end
