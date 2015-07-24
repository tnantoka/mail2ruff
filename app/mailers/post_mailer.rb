class PostMailer < ApplicationMailer
  def receive(email)
    uid = email.to.first.split('@').first.split('+').last
    address = Address.find_by!(uid: uid)

    team = address.team
    note = address.note
    parent = address.page_id
    token = address.token

    title = email.subject
    content = email.body

    if email.has_attachments?
      #list = '<ul>'
      email.attachments.each do |attachment|
        puts attachment.inspect
        #a = create_attachment(team, note, attachment)
        #list << "<li><a href=\"#{a['html_url']}\">#{a['filename']}</a></li>"
      end
      #list << '</ul>'
    end

    #content << "\n#{list}" 
    page = create_page(team, note, title, content, parent)
  end
end
