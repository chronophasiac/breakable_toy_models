require 'spec_helper'

feature "Visitor understands offerings", %{
  As a visitor
  I want to understand what the site is offering
  so I can decide whether to use the app.
  } do

  scenario "Visitor sees a tagline on the main page" do
    visit root_path
    expect(page).to have_content("Memworks is a better way of learning")
  end

  scenario "Visitor sees a brief summary on the main page" do
    visit root_path
    summary = "We leverage the power of spaced repetition "\
              "to help you retain knowledge and keep improving"
    expect(page).to have_content(summary)
  end
  
end
