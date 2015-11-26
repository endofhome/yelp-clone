require "rails_helper"

feature "restaurants" do
  context "no restaurants have been added" do
    scenario "should display a prompt to add a restaurant" do
      visit "/restaurants"
      expect(page).to have_content("No restaurants yet")
      expect(page).to have_link("Add a restaurant")
    end
  end

  context "restaurants have been added" do
    before do
      Restaurant.create(name: "KFC")
    end

    scenario "display restaurants" do
      visit "/restaurants"
      expect(page).to have_content("KFC")
      expect(page).not_to have_content("No restaurants yet")
    end
  end

  context "creating restaurants" do
    scenario "prompts user to fill out a form, then displays the new restaurant" do
      sign_up("test@test.com", "12345678")
      create_restaurant("KFC")
      expect(page).to have_content("KFC")
      expect(current_path).to eq("/restaurants")
    end

    scenario "does not let you submit a name that is too short" do
      sign_up("test@test.com", "12345678")
      create_restaurant("kf")
      expect(page).not_to have_css("h2", text: "kf")
      expect(page).to have_content("error")
    end

    scenario 'user cannot add restaurant if has not logged in' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      expect(page).to have_content "Log in"
      expect(current_path).to eq '/users/sign_in'
    end
  end

  context "viewing restaurants" do
    let!(:kfc){ Restaurant.create(name: "KFC") }

    scenario "lets a user view a restaurant" do
      visit("/restaurants")
      click_link("KFC")
      expect(page).to have_content("KFC")
      expect(current_path).to eq("/restaurants/#{kfc.id}")
    end
  end

  context "editing restaurants" do
    scenario "let a user edit a restaurant" do
      sign_up("test@test.com", "12345678")
      create_restaurant("KFC")
      visit("/restaurants")
      click_link("Edit KFC")
      fill_in("Name", with: "Kentucky Fried Chicken")
      click_button("Update Restaurant")
      expect(page).to have_content("Kentucky Fried Chicken")
      expect(current_path).to eq("/restaurants")
    end

    scenario "user can not edit a restaurant which they didn't create" do
      sign_up("test@test.com", "12345678")
      create_restaurant("KFC")
      sign_out
      sign_up("ronin@ronin.co.uk", "1234qwer")
      visit("/restaurants")
      click_link("Edit KFC")
      expect(page).to have_content("You didn\'t create the restaurant")
    end
  end

  context "deleting restaurants" do
    scenario "removes a restaurant when a user clicks a delete link" do
      sign_up("test@test.com", "12345678")
      create_restaurant("KFC")
      visit("/restaurants")
      click_link("Delete KFC")
      expect(page).not_to have_content("KFC")
      expect(page).to have_content("Restaurant deleted successfully")
    end

    scenario "user can not delete a restaurant which they didn't create" do
      sign_up("test@test.com", "12345678")
      create_restaurant("KFC")
      sign_out
      sign_up("toast@toast.com", "abcdefgh")
      visit("/restaurants")
      click_link("Delete KFC")
      expect(page).to have_content("You didn\'t create the restaurant")
    end
  end

  describe '#average_rating' do
    context 'no reviews' do
      it 'returns "N/A" when there are no reviews' do
        restaurant = Restaurant.create(name: 'The Ivy')
        expect(restaurant.average_rating).to eq('N/A')
      end
    end
  end
end