require "rails_helper"

feature "reviewing" do
  scenario "allows users to leave a review using a form" do
    sign_up("test@test.com", "12345678")
    create_restaurant("KFC")
    create_review("KFC", "yuck", "1")
    expect(current_path).to eq("/restaurants")
    expect(page).to have_content("yuck")
  end

  scenario "a user can only leave one review per restaurant" do
    sign_up("test@test.com", "12345678")    
    create_restaurant("KFC")
    create_review("KFC", "yuck", "1")
    create_review("KFC", "YUM", "5")
    expect(page).to have_content("prohibited this review from being saved")
  end
end