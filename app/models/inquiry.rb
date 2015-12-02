class Inquiry < ActiveRecord::Base
  belongs_to :respondent

  validates :content, presence: true
end
