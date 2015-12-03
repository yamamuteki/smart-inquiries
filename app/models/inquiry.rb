class Inquiry < ActiveRecord::Base
  belongs_to :respondent

  validates :content, presence: true

  def content_hash
    JSON.parse content
  end
end
