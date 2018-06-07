# frozen_string_literal: true

describe BaseForm, type: :model do
  let(:base_form) { build(:base_form) }
  it { should validate_presence_of :user }

  it 'should raise NotImplementedError on update' do
    expect { base_form.update }.to raise_error(NotImplementedError)
  end
end
