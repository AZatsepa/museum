# frozen_string_literal: true

require_relative '../feature_helper'

describe 'Read personalities' do
  context 'when admin' do
    let(:user) { create(:user, :admin) }

    before { login_as(user, scope: :user, run_callbacks: false) }

    it 'shows published personality' do
      create(:personality, name: 'Published personality')
      visit personalities_path
      expect(page).to have_content('Published personality')
    end

    it 'does not show unpublished personality' do
      create(:personality, name: 'Unublished personality', published: false)
      visit personalities_path
      expect(page).not_to have_content('Unublished personality')
    end
  end

  context 'when author' do
    let(:user) { create(:user, :author) }

    before { login_as(user, scope: :user, run_callbacks: false) }

    it 'shows published personality' do
      create(:personality, name: 'Published personality', user: user)
      visit personalities_path
      expect(page).to have_content('Published personality')
    end

    it 'does not show unpublished personality' do
      create(:personality, name: 'Unublished personality', published: false, user: user)
      visit personalities_path
      expect(page).not_to have_content('Unublished personality')
    end
  end

  context 'when user' do
    let(:user) { create(:user) }

    before { login_as(user, scope: :user, run_callbacks: false) }

    it 'shows published personality' do
      create(:personality, name: 'Published personality')
      visit personalities_path
      expect(page).to have_content('Published personality')
    end

    it 'does not show unpublished personality' do
      create(:personality, name: 'Unublished personality', published: false)
      visit personalities_path
      expect(page).not_to have_content('Unublished personality')
    end
  end

  context 'when not authenticated user' do
    it 'shows published personality' do
      create(:personality, name: 'Published personality')
      visit personalities_path
      expect(page).to have_content('Published personality')
    end

    it 'does not show unpublished personality' do
      create(:personality, name: 'Unublished personality', published: false)
      visit personalities_path
      expect(page).not_to have_content('Unublished personality')
    end
  end
end
