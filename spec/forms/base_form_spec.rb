# frozen_string_literal: true

describe BaseForm, type: :model do
  let(:base_form) { build(:base_form) }

  it { is_expected.to validate_presence_of :user }

  it 'raises NotImplementedError on update' do
    expect { base_form.update }.to raise_error(NotImplementedError)
  end
end
