class Respondent < ActiveRecord::Base
  belongs_to :distribution
  has_one :inquiry
  validates :email, presence: true
end
