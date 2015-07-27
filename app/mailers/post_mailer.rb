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
    content = email.html_part.try(:body).to_s.strip
    content = email.text_part.try(:body).to_s.strip if content.empty?

    if email.has_attachments?
      dir = Rails.root.join('tmp', 'attachments', SecureRandom.uuid)
      FileUtils.mkdir_p(dir)
      list = "\n<ul>"
      email.attachments.each do |attachment|
        path = dir.join(attachment.filename)
        File.binwrite(path, attachment.body)
        a = ruffnote.create_attachment(team, note, path.to_s, attachment.content_type)

        replaced = content.gsub!(/<img src="#{attachment.url}/, "<img src=\"#{a['filelink']}")
        unless replaced
          list << "<li><a href=\"#{a['filelink']}\">#{a['filename']}</a></li>"
        end

        FileUtils.rm_rf(path)
      end
      list << "</ul>\n"
    end

    content << "#{list}"
    page = ruffnote.create_page(team, note, title, content, parent)
  end
end
