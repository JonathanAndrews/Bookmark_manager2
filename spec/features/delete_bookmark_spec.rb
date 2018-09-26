feature 'delete bookmark' do
  scenario 'should have a delete button' do
    visit('/delete_bookmarks')
    expect(page).to have_content 'Remove!'
  end

  scenario "should delete Bookmark" do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.google.com');")
    visit "/delete_bookmarks"
    fill_in :url, with: 'wwww.imgur.com'
    click_button "Remove!"

    expect(page).to have_content 'http://www.google.com'

    expect(page).not_to have_content 'www.imgur.com'

  end
end
