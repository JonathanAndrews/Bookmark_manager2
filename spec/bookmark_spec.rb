require './lib/bookmark'

describe Bookmark do
  context ".all" do
    it "should return an Array of Bookmark instances" do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.makersacademy.com', 'Makers');")
      connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.google.com', 'Google');")
      connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.destroyallsoftware.com', 'DAS');")

      expect(Bookmark.all).to include(a_kind_of(Bookmark))
    end
  end

  context ".create" do
    it "should add a new bookmark to database" do
      Bookmark.create("Imgur", "http://www.imgur.com")

      expect((Bookmark.all[0]).title).to include "Imgur"
    end
    it "should reject fake urls" do
      Bookmark.create("gobble", "gobbledy-gook")

      expect(Bookmark.all).to be_empty
    end

  end

  xcontext ".delete" do
    it "should add a new bookmark to database" do
      Bookmark.create("http://www.imgur.com")

      expect(Bookmark.all).to include "http://www.imgur.com"

      Bookmark.delete("http://www.imgur.com")

      expect(Bookmark.all).not_to include "http://www.imgur.com"

    end
  end

  context "#initialize" do
    subject { described_class.new("1", "Google", "https://www.google.com") }
    it 'should take 3 arguments' do
      expect(Bookmark).to respond_to(:new).with(3).arguments
      Bookmark.new("1", "Google", "https://www.google.com")
    end

    it 'sets @id to id argument' do
      expect(subject.id).to eq("1")
    end

    it 'sets @title to title argument' do
      expect(subject.title).to eq("Google")
    end

    it 'sets @url to url argument' do
      expect(subject.url).to eq("https://www.google.com")
    end
  end
end
