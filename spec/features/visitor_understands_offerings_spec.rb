require 'spec_helper'

feature 'Visitor understands offerings', %{
  As a visitor
  I want to understand what the site is offering
  so I can decide whether to use the app
} do

  scenario "Visitor sees a tagline on the main page" do
    visit root_path
    expect(page).to have_content("Learn stuff")
  end

  scenario "Visitor sees a brief summary on the main page" do
    visit root_path
    expect(page).to have_content("We make learning easy by repeatedly injecting content into your brain")
  end
  
end
