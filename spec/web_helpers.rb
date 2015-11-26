module User_helpers
  def sign_up(email, password)
    visit('/')
    click_link('Sign up')
    fill_in(:user_email, with: email)
    fill_in(:user_password, with: password)
    fill_in(:user_password_confirmation, with: password)
    click_button('Sign up')
  end

  def create_restaurant(name)
    visit("/restaurants")
    click_link("Add a restaurant")
    fill_in("Name", with: name)
    click_button("Create Restaurant")
  end

  def sign_out
    click_link("Sign out")
  end

  def create_review(name, thoughts, rating)
    visit("/restaurants")
    click_link("Review #{name}")
    fill_in("Thoughts", with: thoughts)
    select(rating, from: "Rating")
    click_button("Leave Review")
  end
end