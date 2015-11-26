class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.string :content
      t.references :respondent

      t.timestamps null: false
    end
  end
end
