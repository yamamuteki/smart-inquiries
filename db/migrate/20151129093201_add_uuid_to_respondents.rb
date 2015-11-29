class AddUuidToRespondents < ActiveRecord::Migration
  def change
    add_column :respondents, :uuid, :string
  end
end
