require 'rails_helper'

RSpec.describe 'OAuth Access Grant' do
  it 'redirects to login for unauthenticated users' do
    #As a not-signed-in registered user
    user = create :user
    #In order to grant access to an oauth client application
    application = create :oauth_application, name: 'Test App'
    #When I visit the authorize path
    visit "/oauth/authorize?client_id=#{application.uid}&response_type=code&redirect_uri=#{application.redirect_uri}"
    #Then I should see a log in page.
    expect(page).to have_content 'Log in'
  end

  it 'displays grant information to authenticated users' do
    #As a registered user
    user = create :user
    login(user)
    #In order to grant access to an oauth client application
    application = create :oauth_application, name: 'Test App'
    #When I visit the authorization path
    visit "/oauth/authorize?client_id=#{application.uid}&response_type=code&redirect_uri=#{application.redirect_uri}"
    #Then I should see the client app;ication's information
save_and_open_page
    expect(page).to have_content 'Test App'
    #And I should see an option to grant access
    #And I should see an option to deny access
  end
end
