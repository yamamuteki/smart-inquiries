class Distribution < ActiveRecord::Base
  has_many :respondents
  has_many :sent_respondents, -> { where.not first_sent_at: nil }, class_name: 'Respondent'
  has_many :accessed_respondents, -> { where.not accessed_at: nil }, class_name: 'Respondent'
  has_many :answered_respondents, -> { where.not answered_at: nil }, class_name: 'Respondent'

  validates :name, presence: true
end
