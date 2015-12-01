class AddDetailsToRespondents < ActiveRecord::Migration
  def change
    add_column :respondents, :first_sent_at, :datetime
    add_column :respondents, :last_sent_at, :datetime
    add_column :respondents, :sent_count, :integer
    add_column :respondents, :accessed_at, :datetime
    add_column :respondents, :answered_at, :datetime
    remove_column :respondents, :distributed, :boolean
    remove_column :respondents, :answered, :boolean
  end
end
