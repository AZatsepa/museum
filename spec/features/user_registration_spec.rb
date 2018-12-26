# frozen_string_literal: true

require_relative 'feature_helper'

describe 'User registration', %q(
  In order to registration
  I want to create a new account
) do
  context 'when valid steps' do
    before do
      visit new_user_registration_path

      fill_in 'user_email', with: 'test@test.com'
      fill_in 'user_password', with: '12345678'
      fill_in 'user_password_confirmation', with: '12345678'
      click_on t('registration.sign_up')
    end

    it 'creates unconfirmed user' do
      expect(User.find_by(email: 'test@test.com')).not_to be_confirmed
    end

    it 'redirects to edit profile page' do
      user = User.find_by(email: 'test@test.com')
      token = user.confirmation_token
      visit user_confirmation_url(confirmation_token: token)
      expect(page).to have_current_path(edit_user_registration_path(user), ignore_query: true)
    end
  end

  context 'when invalid steps' do
    it 'does not create user' do
      visit new_user_registration_path

      fill_in 'user_email', with: 'test@test.com'
      fill_in 'user_password', with: '12345678'
      fill_in 'user_password_confirmation', with: '123456789'
      click_on t('registration.sign_up')

      expect(User.find_by(email: 'test@test.com')).not_to be_present
    end
  end
end
