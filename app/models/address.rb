class Address < ActiveRecord::Base
  before_create :set_uid

  class << self
    def find_or_create_by_note(note, user)
      address = Address.find_or_initialize_by(note_id: note['id'], user_id: user.uid)
      address.team = note['team']['name']
      address.note = note['name']
      address.token = user.credentials.token
      address.save!
      address
    end
  end

  def email
    "mail2ruff+#{uid}@#{ENV['ADDRESS_HOST']}"
  end

  def to_param
    uid
  end

  def page_url
    "#{ENV['RUFFNOTE_SITE']}#{page_path}"
  end

  def page_path
    path = "#{team}/#{note}/"
    path << "#{page_id}" if page_id.present?
    path
  end

  private
    def set_uid
      begin
        uid = SecureRandom.urlsafe_base64
      end while Address.exists?(uid: uid)
      self.uid = uid
    end
end
