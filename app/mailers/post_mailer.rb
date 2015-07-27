class PostMailer < ApplicationMailer
  def receive(email)
    logger = Rails.logger

    uid = email.to.first.split('@').first.split('+').last
    address = Address.find_by!(uid: uid)

    team = address.team
    note = address.note
    parent = address.page_id
    token = address.token

    ruffnote = Ruffnote.new(token)

    title = email.subject
    content = email.parts.first.try(:body).to_s

    if email.has_attachments?
      #list = '<ul>'
      email.attachments.each do |attachment|
        logger.info ruffnote.attachment.inspect
        #a = create_attachment(team, note, attachment)
        #list << "<li><a href=\"#{a['html_url']}\">#{a['filename']}</a></li>"
      end
      #list << '</ul>'
    end

    #content << "\n#{list}" 
    page = ruffnote.create_page(team, note, title, content, parent)
  end
end
