# frozen_string_literal: true

require_relative '../feature_helper'

describe 'Create personalities' do
  context 'when admin' do
    let(:user) { create(:user, :admin) }

    it 'Authenticated admin creates a new personality' do
      login_as(user, scope: :user, run_callbacks: false)
      visit personalities_path
      expect(page).to have_content t('personalities.label.add')
      click_link(t('personalities.label.add'))

      find('#personality_name').set('Lorem ipsum')
      find('#personality_life_years').set('Lorem ipsum')
      find('#personality_definition').set('Lorem ipsum')
      find('#personality_information').set('Lorem ipsum')
      check 'Published'
      expect do
        click_on t('personalities.button.create')
      end.to change(Personality, :count).by(1)
      expect(page).to have_current_path(personality_path(Personality.last, locale: :en))
      expect(page).to have_content('Lorem ipsum')
    end

    it 'Authenticated admin creates unpublished personality' do
      login_as(user, scope: :user, run_callbacks: false)
      visit personalities_path
      expect(page).to have_content t('personalities.label.add')
      click_link(t('personalities.label.add'))

      find('#personality_name').set('Lorem ipsum')
      find('#personality_life_years').set('Lorem ipsum')
      find('#personality_definition').set('Lorem ipsum')
      find('#personality_information').set('Lorem ipsum')
      expect do
        click_on t('personalities.button.create')
      end.to change(Personality, :count).by(1)
      expect(page).to have_current_path(personalities_path(locale: :en))
      expect(page).to have_content(t('personalities.create.unpublished'))
      expect(page).not_to have_content('Lorem ipsum')
    end
  end

  context 'when author' do
    let(:user) { create(:user, :author) }

    it 'Authenticated author creates a new personality' do
      login_as(user, scope: :user, run_callbacks: false)
      visit personalities_path
      expect(page).to have_content t('personalities.label.add')
      click_link(t('personalities.label.add'))

      find('#personality_name').set('Lorem ipsum')
      find('#personality_life_years').set('Lorem ipsum')
      find('#personality_definition').set('Lorem ipsum')
      find('#personality_information').set('Lorem ipsum')
      check 'Published'
      expect do
        click_on t('personalities.button.create')
      end.to change(Personality, :count).by(1)
      expect(page).to have_current_path(personality_path(Personality.last, locale: :en))
      expect(page).to have_content('Lorem ipsum')
    end

    it 'Authenticated author creates unpublished personality' do
      login_as(user, scope: :user, run_callbacks: false)
      visit personalities_path
      expect(page).to have_content t('personalities.label.add')
      click_link(t('personalities.label.add'))

      find('#personality_name').set('Lorem ipsum')
      find('#personality_life_years').set('Lorem ipsum')
      find('#personality_definition').set('Lorem ipsum')
      find('#personality_information').set('Lorem ipsum')
      expect do
        click_on t('personalities.button.create')
      end.to change(Personality, :count).by(1)
      expect(page).to have_current_path(personalities_path(locale: :en))
      expect(page).to have_content(t('personalities.create.unpublished'))
      expect(page).not_to have_content('Lorem ipsum')
    end
  end

  context 'when user' do
    let(:user) { create(:user) }

    it 'Authenticated user cannot create a new personality' do
      login_as(user, scope: :user, run_callbacks: false)
      visit personalities_path
      expect(page).not_to have_content t('personalities.label.add')
    end
  end

  context 'when not authenticated user' do
    it 'Guest cannot create a new personality' do
      visit personalities_path
      expect(page).not_to have_content t('personalities.label.add')
    end
  end
end
