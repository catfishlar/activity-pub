require 'rails_helper'

feature "Site with Blocked Sites" do

  scenario "account can create site with blocked sites" do
    Given "account can view new site form"
    When "account enters information for site and blocked sites"
    Then "account can see site listing"
  end

  def account_can_view_new_site_form
    visit new_site_path
    expect(page).to have_content("New Admined Site")
  end
  def acccount_enters_information_for_site_and_blocked_sites
    enter_site_info
    enter_blocked_site_info
    click_button "Create Site"
  end
  def account_can_see_site_listing
    expect(page).to have_content("forkhistory.social")
    expect(page).to have_content("badblood.social")
  end

  def enter_site_info
    fill_in("site[name]", with: "forkhistory.social")
  end

  def enter_blocked_site_info
    fill_in("site[blocked_site_attributes[0][name]", with: "badblood.social")
    select('Suspend', :from => "site[blocked_site_attributes[0][level]")
    fill_in("site[blocked_site_attributes[1][name]", with: "hassle.social")
    select('Suspend', :from => "site[blocked_site_attributes[1][level]")
    fill_in("site[blocked_site_attributes[2][name]", with: "spam.social")
    select('Silence', :from => "site[blocked_site_attributes[2][level]")
  end
end