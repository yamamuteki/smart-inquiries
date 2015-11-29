class Distribution < ActiveRecord::Base
  has_many :respondents

  validates :name, presence: true
end
