require 'rails_helper'

feature 'user adds a car', %q(

  As a car salesperson
  I want to record a newly acquired car
  So that I can list it in my lot

) do
  # I must specify the manufacturer, color, year, and mileage of the car (an association between the car and an existing manufacturer should be created).
  # Only years from 1920 and above can be specified.
  # I can optionally specify a description of the car.
  # If I enter all of the required information in the required formats, the car is recorded and I am presented with a notification of success.
  # If I do not specify all of the required information in the required formats, the car is not recorded and I am presented with errors.
  # Upon successfully creating a car, I am redirected back to the index of cars.
  scenario 'successfully creates a car' do
    manufacturer = FactoryGirl.create(:manufacturer)

    visit '/cars'
    click_on 'Add a Car'
    expect(page).to have_content('New Car')
    select 'Ford', from: 'car[manufacturer_id]'
    fill_in 'Model', with: 'Edge'
    fill_in 'Color', with: 'Green'
    fill_in 'Year', with: '2015'
    fill_in 'Mileage', with: '11234'
    fill_in 'Description', with: 'I probably should have gotten the blue one.'
    click_on 'Create Car'

    expect(page).to have_content('Car was successfully created.')
    expect(page).to have_content('Cars')
    expect(page).to have_content('Ford')
    expect(page).to have_content('Edge')
    expect(page).to have_content('Green')
    expect(page).to have_content('2015')
    expect(page).to have_content('11234')
    expect(page).to have_content('I probably should have gotten the blue one.')
  end

  scenario 'fails to create a car by not filling in form' do
    manufacturer = FactoryGirl.create(:manufacturer)

    visit '/cars'
    click_on 'Add a Car'
    expect(page).to have_content('New Car')
    click_on 'Create Car'

    expect(page).to have_content('errors')
    expect(page).to have_content("Model can't be blank")
    expect(page).to have_content("Color can't be blank")
    expect(page).to have_content("Year can't be blank")
    expect(page).to have_content("Mileage is not a number")
    expect(page).to_not have_content("Description can't be blank")
  end

  scenario 'fails creates a car by entering invalid year' do
    manufacturer = FactoryGirl.create(:manufacturer)

    visit '/cars'
    click_on 'Add a Car'
    expect(page).to have_content('New Car')
    select 'Ford', from: 'car[manufacturer_id]'
    fill_in 'Model', with: 'Edge'
    fill_in 'Color', with: 'Green'
    fill_in 'Year', with: '20'
    fill_in 'Mileage', with: '11234'
    click_on 'Create Car'

    expect(page).to have_content('error')
    expect(page).to have_content('Year must be after 1920')
    expect(page).to have_content('Year is the wrong length')
  end
end
