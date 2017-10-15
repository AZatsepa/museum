describe User do
  let(:user) do
    User.create email:    'foo@bar.com',
                password: 'password',
                nickname: 'test'
  end
  it 'should be saved' do
    user.save
    expect(user.errors.messages.size).to eql 0
  end
end
