require 'rails_helper'

RSpec.feature 'Sign up', type: :feature do
  feature 'Process sign up' do
    before do
      visit '/'
      click_on 'Sign up'
    end

    specify do
      expect(page).to have_css('h2', text: 'Sign up')
      expect(page.current_path).to eq new_user_registration_path
    end

    context 'with valid data' do
      scenario 'when avatar is present' do
        fill_in_date_without_avatar
        attach_file('user_avatar', "#{Rails.root}/spec/fixtures/pixel.png")

        expect { click_button 'Sign up' }.to change(User, :count).by(1)

        expect(page).to have_css('.alert-info', text: 'Welcome! You have signed up successfully.')
        expect(page).to have_css('h2', text: 'User preview')
        expect(page.find('img')['src']).to have_content 'pixel.png'
        expect(page.current_path).to eq preview_path

        click_on 'Continue'

        expect(page.current_path).to eq root_path
        expect(page).to have_content 'Sign out'
      end

      scenario 'when avatar is blank' do
        fill_in_date_without_avatar

        expect { click_button 'Sign up' }.to change(User, :count).by(1)

        expect(page).to have_css('.alert-info', text: 'Welcome! You have signed up successfully.')
        expect(page).to have_content 'Sign out'
        expect(page.current_path).to eq root_path
      end
    end

    context 'with invalid data' do
      scenario 'when all fields are empty' do
        expect { click_button 'Sign up' }.to change(User, :count).by(0)

        expect(page).to have_css('.alert-danger', text: 'Please review the problems below:')
        expect(page).to have_css('.user_email .help-block', text: 'can\'t be blank')
        expect(page).to have_css('.user_nickname .help-block', text: 'can\'t be blank')
        expect(page).to have_css('.user_password .help-block', text: 'can\'t be blank')
        expect(page).to have_css('.user_password .help-block', text: '6 characters minimum')
        expect(page.current_path).to eq user_registration_path
      end

      scenario 'when email is incorrect' do
        fill_in 'Email', with: 'email'

        click_button 'Sign up'

        expect(page).to have_css('.user_email .help-block', text: 'is invalid')
        expect(page.current_path).to eq user_registration_path
      end

      scenario 'when the password does not match' do
        fill_in 'user[password]', with: '111111'
        fill_in 'Password confirmation', with: '123456'

        click_button 'Sign up'

        expect(page).to have_css('.user_password_confirmation .help-block', text: 'doesn\'t match Password')
        expect(page.current_path).to eq user_registration_path
      end

      scenario 'when the nickname more 20 characters' do
        fill_in 'Nickname', with: 'default_nickname' * 2

        click_button 'Sign up'

        expect(page).to have_css('.user_nickname .help-block', text: 'is too long (maximum is 20 characters)')
        expect(page.current_path).to eq user_registration_path
      end
    end
  end

  private

  def fill_in_date_without_avatar
    fill_in 'Email', with: 'email@mail.com'
    fill_in 'Nickname', with: 'default_nickname'
    fill_in 'user[password]', with: '111111'
    fill_in 'Password confirmation', with: '111111'
  end
end
