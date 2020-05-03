# frozen_string_literal: true

describe PersonalitiesController, type: :controller do
  let(:user) { create(:user) }
  let(:author) { create(:user, :author) }
  let(:admin) { create(:user, :admin) }

  describe 'GET #index' do
    before { create_list(:personality, 5) }

    it 'assigns @personalities' do
      get :index
      expect(assigns(:personalities)).to match_array Personality.all
    end

    it 'renders only published posts' do
      create_list(:personality, 10, :unpublished)
      get :index
      expect(assigns(:personalities).map(&:published)).not_to include(false)
    end

    context 'when sorting' do
      it 'sorts by id asc' do
        get :index
        expect(assigns(:personalities).first).to eq Personality.published.order(id: :asc).first
      end

      it 'sorts by id desc' do
        get :index, params: { order: :id, direction: :desc }
        expect(assigns(:personalities).first).to eq Personality.published.order(id: :desc).first
      end

      it 'sorts by name asc' do
        get :index, params: { order: :name, direction: :asc }
        expect(assigns(:personalities).first).to eq Personality.published.order(name: :asc).first
      end

      it 'sorts by name desc' do
        get :index, params: { order: :name, direction: :desc }
        expect(assigns(:personalities).first).to eq Personality.published.order(name: :desc).first
      end

      it 'sorts by life_years asc' do
        get :index, params: { order: :life_years, direction: :asc }
        expect(assigns(:personalities).first).to eq Personality.published.order(life_years: :asc).first
      end

      it 'sorts by life_years desc' do
        get :index, params: { order: :life_years, direction: :desc }
        expect(assigns(:personalities).first).to eq Personality.published.order(life_years: :desc).first
      end

      it 'sorts by definition asc' do
        get :index, params: { order: :definition, direction: :asc }
        expect(assigns(:personalities).first).to eq Personality.published.order(definition: :asc).first
      end

      it 'sorts by definition desc' do
        get :index, params: { order: :definition, direction: :desc }
        expect(assigns(:personalities).first).to eq Personality.published.order(definition: :desc).first
      end

      it 'sorts by information asc' do
        get :index, params: { order: :information, direction: :asc }
        expect(assigns(:personalities).first).to eq Personality.published.order(information: :asc).first
      end

      it 'sorts by information desc' do
        get :index, params: { order: :information, direction: :desc }
        expect(assigns(:personalities).first).to eq Personality.published.order(information: :desc).first
      end
    end
  end

  describe 'GET show' do
    context 'when published' do
      let(:personality) { create(:personality) }

      it 'assigns personality to @personality' do
        get :show, params: { id: personality }
        expect(assigns(:personality)).to eq personality
      end

      it 'renders template show' do
        expect(
          get(:show, params: { id: personality })
        ).to render_template :show
      end

      it 'has success status' do
        get :show, params: { id: personality }
        expect(response.status).to eq 200
      end
    end

    context 'when unpublished personality' do
      let(:personality) { create(:personality, :unpublished) }

      it 'redirects to root path' do
        get :show, params: { id: personality }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #new' do
    context 'when admin' do
      before do
        request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in admin
      end

      it 'renders template :new' do
        expect(
          get(:new)
        ).to render_template :new
      end

      it 'has success status' do
        get :new
        expect(response.status).to eq 200
      end
    end

    context 'when author' do
      before do
        request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in author
      end

      it 'renders template :new' do
        expect(
          get(:new)
        ).to render_template :new
      end

      it 'has success status' do
        get :new
        expect(response.status).to eq 200
      end
    end

    context 'when user' do
      before do
        request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in user
      end

      it 'does not render template :new' do
        expect(
          get(:new)
        ).not_to render_template :new
      end

      it 'redirects to root path' do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #create' do
    context 'when author' do
      before do
        request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in author
      end

      context 'when valid' do
        it 'creates personality' do
          expect do
            post :create, params: { personality: attributes_for(:personality) }
          end.to change(Personality, :count).by(1)
        end
      end

      context 'when invalid' do
        it 'does not create personality' do
          expect do
            post :create, params: { personality: attributes_for(:personality, :invalid) }
          end.not_to change(Personality, :count)
        end

        it 'renders error messages' do
          expect(
            post(:create, params: { personality: attributes_for(:personality, :invalid) })
          ).to render_template :new
        end
      end
    end

    context 'when admin' do
      before do
        request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in admin
      end

      context 'when valid' do
        it 'creates personality' do
          expect do
            post :create, params: { personality: attributes_for(:personality) }
          end.to change(Personality, :count).by(1)
        end
      end

      context 'when invalid' do
        it 'does not create personality' do
          expect do
            post :create, params: { personality: attributes_for(:personality, :invalid) }
          end.not_to change(Personality, :count)
        end

        it 'renders error messages' do
          expect(
            post(:create, params: { personality: attributes_for(:personality, :invalid) })
          ).to render_template :new
        end
      end
    end

    context 'when user' do
      before do
        request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in user
      end

      it 'redirects to root path' do
        post :create, params: { personality: attributes_for(:personality) }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH #update' do
    let(:personality) { create(:personality, user: author) }
    let(:other_personality) { create(:personality) }

    context 'when author' do
      context 'when own personality' do
        before do
          request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in author
          patch :update, params: { id: personality, personality: { name: 'updated text' } }
        end

        it 'assigns comment to @personality' do
          expect(assigns(:personality)).to eql personality
        end

        it 'updates personality' do
          personality.reload
          expect(personality.name).to eql('updated text')
        end

        it 'redirects to personality' do
          expect(response.status).to be 302
        end
      end

      context "when other user's personality" do
        before do
          request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in user
        end

        it 'does not update personality' do
          expect do
            patch :update,
                  params: { id: other_personality, personality: { name: 'updated text' } }
          end.not_to change(other_personality, :name)
        end

        it 'does not render edit template' do
          expect(
            patch(:update,
                  params: { id: other_personality, personality: { name: 'updated text' } })
          ).not_to render_template :update
        end
      end
    end

    context 'when admin' do
      before do
        request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in admin
        patch :update, params: { id: personality, personality: { name: 'updated text' } }
      end

      it 'assigns personality to @personality' do
        expect(assigns(:personality)).to eql personality
      end

      it 'updates personality' do
        personality.reload
        expect(personality.name).to eql('updated text')
      end
    end

    context 'when user' do
      before do
        request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in user
        patch :update, params: { id: personality, personality: { name: 'updated text' } }
      end

      it 'redirects to root path' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:personality) { create(:personality, user: author) }
    let!(:other_personality) { create(:personality) }

    context 'when author' do
      context 'when own personality' do
        before do
          request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in author
        end

        it 'assigns personality to @personality' do
          delete :destroy, params: { id: personality }
          expect(assigns(:personality)).to eql personality
        end

        it 'destroys personality' do
          expect do
            delete(:destroy, params: { id: personality })
          end.to change(Personality, :count).by(-1)
        end

        it 'redirects to personalities_path' do
          expect(
            delete(:destroy, params: { id: personality })
          ).to redirect_to personalities_path
        end
      end

      context "when other author's personality" do
        before do
          request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in create(:user, :author)
        end

        it 'does not destroy personality' do
          expect do
            delete(:destroy, params: { id: other_personality })
          end.not_to change(Personality, :count)
        end
      end
    end

    context 'when admin' do
      before do
        request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in admin
      end

      it 'assigns personality to @personality' do
        delete(:destroy, params: { id: personality })
        expect(assigns(:personality)).to eql personality
      end

      it 'destroys personality' do
        expect do
          delete(:destroy, params: { id: personality })
        end.to change(Personality, :count).by(-1)
      end

      it 'redirects to personalities_path' do
        expect(
          delete(:destroy, params: { id: personality })
        ).to redirect_to personalities_path
      end
    end

    context 'when user' do
      before do
        request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in user
        delete(:destroy, params: { id: personality })
      end

      it 'does not destroy personality' do
        expect do
          delete(:destroy, params: { id: other_personality })
        end.not_to change(Personality, :count)
      end

      it 'redirects to root path' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
