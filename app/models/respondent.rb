class Respondent < ActiveRecord::Base
  belongs_to :distribution
  has_one :inquiry
  validates :email, presence: true

  def status
    return '回答済' if answered_at
    return '開封済' if accessed_at
    return '配信済' if first_sent_at
    '未配信'
  end
end
