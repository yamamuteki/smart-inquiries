class Respondent < ActiveRecord::Base
  after_initialize :set_default, if: :new_record?

  belongs_to :distribution
  has_one :inquiry, dependent: :destroy

  validates :email, presence: true

  def status
    return '回答済' if answered_at
    return '開封済' if accessed_at
    return '配信済' if first_sent_at
    '未配信'
  end

  def update_sent_attributes
    now = Time.zone.now
    self.first_sent_at ||= now
    self.last_sent_at = now
    self.sent_count ||= 0
    self.sent_count += 1
    save
  end

  def update_accessed_at
    update accessed_at: Time.zone.now
  end

  def update_answered_at
    update answered_at: Time.zone.now
  end

  private
  def set_default
    self.uuid ||= SecureRandom.uuid
  end
end
