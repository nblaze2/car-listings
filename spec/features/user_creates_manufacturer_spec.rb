require 'rails_helper'

feature 'user adds a manufacturer', %q(

  As a car salesperson
  I want to record a car manufacturer
  So that I can keep track of the types of cars found in the lot

) do
  # I must specify a manufacturer name and country.
  # If I do not specify the required information, I am presented with errors.
  # If I specify the required information, the manufacturer is recorded and I am redirected to the index of manufacturers
  scenario 'successfully creates a manufacturer' do
    manufacturer = FactoryGirl.create(:manufacturer)

    visit '/' # redirect to /manufacturers
    click_on 'Add a Manufacturer'
    expect(page).to have_content('New Manufacturer')
    fill_in 'Name', with: 'Toyota'
    fill_in 'Country', with: 'Japan'
    click_on 'Create Manufacturer'

    expect(page).to have_content('Manufacturer was successfully created.')
    expect(page).to have_content('Manufacturers')
    expect(page).to have_content('Ford')
    expect(page).to have_content('America')
    expect(page).to have_content('Toyota')
    expect(page).to have_content('Japan')
  end

  scenario 'fails to creates a manufacturer' do
    visit '/'
    click_on 'Add a Manufacturer'
    expect(page).to have_content('New Manufacturer')
    click_on 'Create Manufacturer'

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Country can't be blank")
    expect(page).to have_content('New Manufacturer')
  end
end
