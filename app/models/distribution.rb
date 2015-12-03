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

  def answered_csv
    require 'csv'
    headers = ['#', 'distribution', 'email', 'answered_at', 'q1', 'q2', 'q3']
    csv_data = CSV.generate force_quotes: true, write_headers: true, headers: headers do |csv|
      answered_respondents.each_with_index do |respondent, index|
        csv << [index + 1, name, respondent.email, respondent.answered_at] + respondent.inquiry.content_hash.values
      end
    end
    csv_data.encode(Encoding::SJIS)
  end

  def self.answered_csv_all
    csv = all.reduce('') { |acum, distribution| acum << distribution.answered_csv }
  end

 private

  def rate(count)
    return 0 if respondents.count == 0
    count / respondents.count.to_f * 100
  end
end
