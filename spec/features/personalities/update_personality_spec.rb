# frozen_string_literal: true

require_relative '../feature_helper'

describe 'Update personalities' do
  let!(:personality) { create(:personality) }

  context 'when admin' do
    let(:user) { create(:user, :admin) }

    before do
      login_as(user, scope: :user, run_callbacks: false)
      visit personalities_path
      find("a[data-edit-personality='#{personality.id}']").click
    end

    context 'when valid data' do
      it "changes personality's name" do
        find('#personality_name').set('Changed name')
        click_on t('personalities.button.create')
        expect(page).to have_current_path(personality_path(personality, locale: :en))
        expect(page).to have_content('Changed name')
      end

      it "changes personality's life_years" do
        find('#personality_life_years').set('1700-1755')
        click_on t('personalities.button.create')
        expect(page).to have_current_path(personality_path(personality, locale: :en))
        expect(page).to have_content('1700-1755')
      end

      it "changes personality's definition" do
        find('#personality_definition').set('Warrior')
        click_on t('personalities.button.create')
        expect(page).to have_current_path(personality_path(personality, locale: :en))
        expect(page).to have_content('Warrior')
      end

      it "changes personality's information" do
        find('#personality_information').set("One of the first Izyum's colonels")
        click_on t('personalities.button.create')
        expect(page).to have_current_path(personality_path(personality, locale: :en))
        expect(page).to have_content("One of the first Izyum's colonels")
      end

      it "changes personality's published status" do
        find('#personality_published').set(false)
        click_on t('personalities.button.create')
        expect(page).to have_current_path(personalities_path(locale: :en))
        expect(page).to have_content('Personality has been updated successfully, but is unpublished yet')
      end
    end

    context 'when invalid data' do
      it "cannot change personality's name" do
        find('#personality_name').set('')
        click_on t('personalities.button.create')
        expect(page).to have_current_path(personality_path(personality, locale: :en))
        expect(page).to have_content("Name can't be blank")
      end
    end
  end

  context 'when author' do
    let(:user) { create(:user, :author) }
    let!(:personality) { create(:personality, user: user) }

    before do
      login_as(user, scope: :user, run_callbacks: false)
      visit personalities_path
      find("a[data-edit-personality='#{personality.id}']").click
    end

    context 'when valid data' do
      it "changes personality's name" do
        find('#personality_name').set('Changed name')
        click_on t('personalities.button.create')
        expect(page).to have_current_path(personality_path(personality, locale: :en))
        expect(page).to have_content('Changed name')
      end

      it "changes personality's life_years" do
        find('#personality_life_years').set('1700-1755')
        click_on t('personalities.button.create')
        expect(page).to have_current_path(personality_path(personality, locale: :en))
        expect(page).to have_content('1700-1755')
      end

      it "changes personality's definition" do
        find('#personality_definition').set('Warrior')
        click_on t('personalities.button.create')
        expect(page).to have_current_path(personality_path(personality, locale: :en))
        expect(page).to have_content('Warrior')
      end

      it "changes personality's information" do
        find('#personality_information').set("One of the first Izyum's colonels")
        click_on t('personalities.button.create')
        expect(page).to have_current_path(personality_path(personality, locale: :en))
        expect(page).to have_content("One of the first Izyum's colonels")
      end

      it "changes personality's published status" do
        find('#personality_published').set(false)
        click_on t('personalities.button.create')
        expect(page).to have_current_path(personalities_path(locale: :en))
        expect(page).to have_content('Personality has been updated successfully, but is unpublished yet')
      end
    end

    context 'when invalid data' do
      it "cannot change personality's name" do
        find('#personality_name').set('')
        click_on t('personalities.button.create')
        expect(page).to have_current_path(personality_path(personality, locale: :en))
        expect(page).to have_content("Name can't be blank")
      end
    end
  end

  context 'when other author' do
    let(:user) { create(:user, :author) }

    it 'cannot change personality' do
      visit personalities_path
      expect(page).not_to have_selector("a[data-edit-personality='#{personality.id}']")
    end
  end

  context 'when user' do
    let(:user) { create(:user) }

    it 'cannot change personality' do
      visit personalities_path
      expect(page).not_to have_selector("a[data-edit-personality='#{personality.id}']")
    end
  end

  context 'when not authenticated user' do
    it 'cannot change personality' do
      visit personalities_path
      expect(page).not_to have_selector("a[data-edit-personality='#{personality.id}']")
    end
  end
end
