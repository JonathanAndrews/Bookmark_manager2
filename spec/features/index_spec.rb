feature 'index_page' do
  scenario 'should have title of bookmarks' do
    visit('/')
    expect(page).to have_content "Bookmarks"
  end
end

feature 'bookmarks' do
  scenario 'should give us a list of bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.makersacademy.com', 'Makers');")
    connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.google.com', 'Google');")
    connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.destroyallsoftware.com', 'DAS');")

    visit('/bookmarks')
    expect(page).to have_link('Makers', href: 'http://www.makersacademy.com')
    expect(page).to have_link('Google', href: 'http://www.google.com')
    expect(page).to have_link('DAS', href: 'http://www.destroyallsoftware.com')
  end
end
