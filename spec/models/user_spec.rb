# frozen_string_literal: true

describe User, type: :model do
  let(:user) { build(:user) }

  it { is_expected.to have_many :authentications }
  it { is_expected.to have_many :posts }
  it { is_expected.to have_many :comments }

  it 'is saved' do
    user.save
    expect(user.errors.messages.size).to be 0
  end

  describe '.find_for_oauth' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }

    context 'when user already has authorization' do
      it 'returns the user' do
        user.authentications.create(provider: 'facebook', uid: '123456')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'when user has not authorization' do
      context 'when user already exists' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: user.email }) }

        it 'does not create new user' do
          expect { User.find_for_oauth(auth) }.not_to change(User, :count)
        end

        it 'creates authorization for user' do
          expect { User.find_for_oauth(auth) }.to change(user.authentications, :count).by(1)
        end

        it 'creates authorization with provider' do
          authentication = User.find_for_oauth(auth).authentications.first
          expect(authentication.provider).to eq auth.provider
        end

        it 'creates authorization with uid' do
          authentication = User.find_for_oauth(auth).authentications.first
          expect(authentication.uid).to eq auth.uid
        end

        it 'returns the user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end

      context 'when user does not exist' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: 'new@user.com' }) }

        it 'creates new user' do
          expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
        end

        it 'returns new user' do
          expect(User.find_for_oauth(auth)).to be_a(User)
        end

        it 'fills user email' do
          user = User.find_for_oauth(auth)
          expect(user.email).to eq auth.info[:email]
        end

        it 'creates authorization for user' do
          user = User.find_for_oauth(auth)
          expect(user.authentications).not_to be_empty
        end

        it 'creates authorization with provider' do
          authentication = User.find_for_oauth(auth).authentications.first
          expect(authentication.provider).to eq auth.provider
        end

        it 'creates authorization with uid' do
          authentication = User.find_for_oauth(auth).authentications.first
          expect(authentication.uid).to eq auth.uid
        end
      end
    end
  end
end
