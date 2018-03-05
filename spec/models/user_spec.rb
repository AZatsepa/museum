describe User do
  let(:user) { build(:user) }
  it 'should be saved' do
    user.save
    expect(user.errors.messages.size).to eql 0
  end
end
