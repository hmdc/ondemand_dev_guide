# frozen_string_literal: true

class Dataverse

  def self.search(title)
    connection = Faraday.new(url: 'https://demo.dataverse.org')
    response = connection.get('/api/search?q=title:' + title)
    JSON.parse(response.body)
  end
end
