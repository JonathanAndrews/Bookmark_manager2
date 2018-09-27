require 'pg'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id, title, url)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect dbname: 'bookmark_manager_test'
    else
      con = PG.connect dbname: 'bookmark_manager'
    end

    table = con.exec "SELECT * FROM bookmarks"

    table.map do |row|
      self.new(row['id'], row['title'], row['url'])
    end
  end

  def self.create(title, url)

    return false unless is_url?(url)

    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect dbname: 'bookmark_manager_test'
    else
      con = PG.connect dbname: 'bookmark_manager'
    end

    string = "INSERT INTO bookmarks (url, title) VALUES ('" + url + "', '" + title + "') RETURNING id, title, url;"
    result = con.exec(string)
    Bookmark.new(result[0]['id'], result[0]['title'], result[0]['url'])
  end

  def self.delete(url)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect dbname: 'bookmark_manager_test'
    else
      con = PG.connect dbname: 'bookmark_manager'
    end

    string = "DELETE FROM bookmarks WHERE url = '" + url + "';"
    con.exec(string)

  end

  private

  def self.is_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end
end
