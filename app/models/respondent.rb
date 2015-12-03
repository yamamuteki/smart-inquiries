class Respondent < ActiveRecord::Base
  after_initialize :set_default, if: :new_record?

  belongs_to :distribution
  has_one :inquiry, dependent: :destroy

  validates :email, presence: true

  def status
    return :answered if answered_at
    return :accessed if accessed_at
    return :sent if first_sent_at
    :unsent
  end

  def status_label
    I18n.t status.to_s, scope: [:activerecord, :enums, :respondent, :status]
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
