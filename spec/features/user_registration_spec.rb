require_relative 'feature_helper'

feature 'User registration', %q(
  In order to registration
  I want to create a new account
) do
  context 'when valid steps' do
    before do
      visit new_user_registration_path

      fill_in t('registration.email'), with: 'test@test.com'
      fill_in t('registration.password'), with: '12345678'
      fill_in t('registration.password_confirmation'), with: '12345678'
      click_on t('registration.sign_up')
    end
    scenario 'should create unconfirmed user' do
      expect(User.find_by(email: 'test@test.com')).to_not be_confirmed
    end

    scenario 'should redirect to edit profile page' do
      user = User.find_by(email: 'test@test.com')
      token = user.confirmation_token
      visit user_confirmation_url(confirmation_token: token)
      expect(current_path).to eql edit_user_registration_path(user)
    end
  end

  context 'when invalid steps' do
    scenario 'should not create user' do
      visit new_user_registration_path

      fill_in t('registration.email'), with: 'test@test.com'
      fill_in t('registration.password'), with: '12345678'
      fill_in t('registration.password_confirmation'), with: '123456789'
      click_on t('registration.sign_up')

      expect(User.find_by(email: 'test@test.com')).to_not be_present
    end
  end
end
