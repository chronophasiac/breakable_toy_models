require 'spec_helper'

feature "User confirms email", %Q{
  As a newly registered User
  I want to receive an email telling me about my registration
  so I can be sure I provided the right credentials.
  } do

  given(:email)     { 'user@example.com' }
  given(:password)  { 'password'}

  scenario "User receives an email after signing up" do
    prev_deliveries = ActionMailer::Base.deliveries.count
    visit new_user_registration_path
    fill_in 'Email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
    click_button 'Sign up'
    expect(ActionMailer::Base.deliveries.count).to eql(prev_deliveries + 1)
  end

  scenario "User sees a link to confirm email" do
    visit new_user_registration_path
    fill_in 'Email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
    click_button 'Sign up'
    last_delivery = ActionMailer::Base.deliveries.last
    expect(last_delivery.body).to include('Confirm my account')
  end

  scenario "User sees a message that their email has been confirmed" do
    visit new_user_registration_path
    fill_in 'Email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
    click_button 'Sign up'
    confirmation_link = "/users/confirmation?confirmation_token=#{User.last.confirmation_token}"
    visit confirmation_link
    expect(page).to have_content("Your account was successfully confirmed")
  end

end
