require 'rails_helper'

RSpec.feature 'Sign in', type: :feature do
  feature 'Process sign in' do
    let!(:user) { create :user, email: 'email@mail.com', password: '111111' }

    before do
      visit '/'
      click_on 'Sign in'
    end

    specify do
      expect(page).to have_css('h2', text: 'Log in')
      expect(page.current_path).to eq new_user_session_path
    end

    scenario 'check sign up page' do
      find(:xpath, "(//a[text()='Sign up'])[2]").click

      expect(page).to have_css('h2', text: 'Sign up')
      expect(page.current_path).to eq new_user_registration_path
    end

    scenario 'check forgot your password page' do
      click_on 'Forgot your password'

      expect(page).to have_css('h2', text: 'Forgot your password?')
      expect(page.current_path).to eq new_user_password_path
    end

    context 'authentication process' do
      scenario 'with valid data' do
        fill_in 'Email', with: 'email@mail.com'
        fill_in 'Password', with: '111111'

        click_on 'Log in'

        expect(page).to have_css('.alert-info', text: 'Signed in successfully.')
        expect(page).to_not have_content 'Log in'
        expect(page).to_not have_content 'Sign up'
        expect(page.current_path).to eq root_path
      end

      scenario 'with invalid data' do
        fill_in 'Email', with: 'not_email@mail.com'
        fill_in 'Password', with: '111111'

        click_on 'Log in'

        expect(page).to have_css('.alert-danger', text: 'Invalid Email or password.')
        expect(page).to have_css('h2', text: 'Log in')
        expect(page.current_path).to eq new_user_session_path
      end
    end
  end
end
