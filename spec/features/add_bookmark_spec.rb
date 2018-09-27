feature 'add bookmark' do
  scenario 'should let user add bookmarks' do
    visit("/add_bookmarks")
    expect(page).to have_button ('Add!')
  end

  scenario 'should redirect to bookmarks page after submission ' do
    visit('/add_bookmarks')
    fill_in :bookmark, with: 'http://www.imgur.com'
    fill_in :title, with: 'Imgur'
    click_button 'Add!'
    expect(page).to have_link('Imgur', href: 'http://www.imgur.com')
  end

  scenario 'should alert user if they input a wrong URL' do
    visit('/add_bookmarks')
    fill_in :bookmark, with: 'gobbledy-gook'
    fill_in :title, with: 'gobbledy-gook'
    click_button 'Add!'
    expect(page).not_to have_content('gobbledy-gook')
    expect(page).to have_content("Not a real string")
  end
end
