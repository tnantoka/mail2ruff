class Ruffnote
  attr_accessor :client, :access_token

  def initialize(token)
    self.client = OAuth2::Client.new(
      ENV['RUFFNOTE_CLIENT_ID'],
      ENV['RUFFNOTE_CLIENT_SECRET'],
      site: ENV['RUFFNOTE_SITE'],
      ssl: { verify: false }
    )
    self.access_token = OAuth2::AccessToken.new(client, token)
  end

  def notes(type = nil, team = nil)
    access_token.get("/api/v1/notes.json?type=#{type}&team=#{team}").parsed
  end

  def managed_notes
    notes.select { |n| n['can_manage'] == true }
  end

  def pages(team, note, parent = nil, page = nil)
    access_token.get("/api/v1/#{team}/#{note}/pages?parent=#{parent}&page=#{page}").parsed
  end

  def create_page(team, note, title, content, parent)
    access_token.post("/api/v1/#{team}/#{note}/pages", body: {
      page: {
        title: title,
        content: content,
        parent: parent,
      }
    }).parsed
  end

  def create_attachment(team, note, file)
    json = @token.post("/api/v1/#{team}/#{note}/attachments", body: {
      file: Faraday::UploadIO.new(file, 'image/png'),
    }).parsed
  end
end
