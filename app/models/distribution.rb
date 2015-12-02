class Distribution < ActiveRecord::Base
  has_many :respondents, dependent: :destroy
  has_many :sent_respondents, -> { where.not first_sent_at: nil }, class_name: 'Respondent'
  has_many :accessed_respondents, -> { where.not accessed_at: nil }, class_name: 'Respondent'
  has_many :answered_respondents, -> { where.not answered_at: nil }, class_name: 'Respondent'
  has_many :not_answered_respondents, -> { where answered_at: nil }, class_name: 'Respondent'

  validates :name, presence: true

  def sent_respondents_count
    sent_respondents.count
  end

  def accessed_respondents_count
    accessed_respondents.count
  end

  def answered_respondents_count
    sent_respondents.count
  end

  def sent_respondents_rate
    rate sent_respondents.count
  end

  def accessed_respondents_rate
    rate accessed_respondents.count
  end

  def answered_respondents_rate
    rate sent_respondents.count
  end

 private

  def rate(count)
    return 0 if respondents.count == 0
    count / respondents.count.to_f * 100
  end
end
