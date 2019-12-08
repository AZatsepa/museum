# frozen_string_literal: true

describe BookBibliography, type: :model do
  let(:user) { create(:user) }
  let(:book_bibliography) { build(:book_bibliography, user: user) }

  it { is_expected.to belong_to :user }

  it { is_expected.to validate_presence_of :authors }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :publishing_year }
  it { is_expected.to validate_presence_of :events_years }
  it { is_expected.to validate_presence_of :page }
  it { is_expected.to validate_presence_of :annotation }
  it { is_expected.not_to validate_presence_of :user }

  context 'when valid' do
    it 'is saved' do
      book_bibliography.save
      expect(book_bibliography.errors.messages.size).to be 0
    end
  end

  context 'when invalid' do
    it 'is not saved with empty title' do
      book_bibliography.title = nil
      expect(book_bibliography).not_to be_valid
    end

    it 'is not saved with empty authors' do
      book_bibliography.authors = nil
      expect(book_bibliography).not_to be_valid
    end
  end
end
