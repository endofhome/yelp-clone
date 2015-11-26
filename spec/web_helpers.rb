module User_helpers
  def sign_up
    visit('/')
    click_link('Sign up')
    fill_in(:user_email, with: 'testing@test.com')
    fill_in(:user_password, with: '12345678')
    fill_in(:user_password_confirmation, with: '12345678')
    click_button('Sign up')
  end
end