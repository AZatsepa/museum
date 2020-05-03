# frozen_string_literal: true

require_relative '../feature_helper'

describe 'Delete personalities', js: true do
  let!(:personality) { create(:personality) }

  context 'when admin' do
    let(:user) { create(:user, :admin) }

    before { login_as(user, scope: :user, run_callbacks: false) }

    it 'deletes personality' do
      visit personalities_path
      find("a[data-delete-personality='#{personality.id}']").click
      page.accept_confirm
      expect(page).not_to have_content(personality.name)
      expect(page).to have_content('Personality has been deleted')
    end
  end

  context 'when author' do
    let(:user) { create(:user, :author) }
    let!(:personality) { create(:personality, user: user) }

    before { login_as(user, scope: :user, run_callbacks: false) }

    it 'deletes personality' do
      visit personalities_path
      find("a[data-delete-personality='#{personality.id}']").click
      page.accept_confirm
      expect(page).not_to have_content(personality.name)
      expect(page).to have_content('Personality has been deleted')
    end
  end

  context 'when other author' do
    let(:user) { create(:user, :author) }

    before { login_as(user, scope: :user, run_callbacks: false) }

    it 'cannot delete personality' do
      visit personalities_path
      expect(page).not_to have_selector("a[data-delete-personality='#{personality.id}']")
    end
  end

  context 'when user' do
    let(:user) { create(:user) }

    before { login_as(user, scope: :user, run_callbacks: false) }

    it 'cannot delete personality' do
      visit personalities_path
      expect(page).not_to have_selector("a[data-delete-personality='#{personality.id}']")
    end
  end

  context 'when not authenticated user' do
    it 'cannot delete personality' do
      visit personalities_path
      expect(page).not_to have_selector("a[data-delete-personality='#{personality.id}']")
    end
  end
end
