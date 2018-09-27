feature 'delete bookmark' do
  scenario 'should have a delete button' do
    visit('/delete_bookmarks')
    expect(page).to have_content 'Remove!'
  end

  scenario "should delete Bookmark" do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("INSERT INTO bookmarks (url, title) VALUES ('https://www.google.com', 'Google');")
    connection.exec("INSERT INTO bookmarks (url, title) VALUES ('https://www.imgur.com', 'Imgur');")
    visit "/delete_bookmarks"
    fill_in :url, with: 'https://www.imgur.com'
    click_button "Remove!"

    expect(page).to have_content 'Google'

    expect(page).not_to have_content 'Imgur'

  end
end
