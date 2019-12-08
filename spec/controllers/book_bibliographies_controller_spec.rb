# frozen_string_literal: true

describe BookBibliographiesController, type: :controller do
  let(:user) { create(:user, role: :author) }
  let(:admin) { create(:user, :admin) }

  describe 'POST #create' do
    before do
      request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
    end

    context 'when valid' do
      it 'creates book bibliography' do
        expect do
          post :create, params: { book_bibliography: attributes_for(:book_bibliography) }
        end.to change(BookBibliography, :count).by(1)
      end
    end

    context 'when invalid' do
      it 'does not create book bibliography' do
        expect do
          post :create, params: { book_bibliography: attributes_for(:book_bibliography, :invalid) }
        end.not_to change(BookBibliography, :count)
      end

      it 'renders error messages' do
        expect(
          post(:create, params: { book_bibliography: attributes_for(:book_bibliography, :invalid) })
        ).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    let(:book_bibliography) { create(:book_bibliography, user: user) }
    let(:other_book_bibliography) { create(:book_bibliography) }

    context 'when user' do
      context 'when own book_bibliography' do
        before do
          request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in user
          patch :update, params: { id: book_bibliography, book_bibliography: { title: 'updated text' } }
        end

        it 'assigns comment to @book_bibliography' do
          expect(assigns(:book_bibliography)).to eql book_bibliography
        end

        it 'updates book_bibliography' do
          book_bibliography.reload
          expect(book_bibliography.title).to eql('updated text')
        end

        it 'redirects to  book bibliography' do
          expect(response.status).to be 302
        end
      end

      context "when other user's book_bibliography" do
        before do
          request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in user
        end

        it 'does not update book_bibliography' do
          expect do
            patch :update,
                  params: { id: other_book_bibliography, book_bibliography: { title: 'updated text' } }
          end.not_to change(other_book_bibliography, :title)
        end

        it 'does not render edit template' do
          expect(
            patch(:update,
                  params: { id: other_book_bibliography, book_bibliography: { title: 'updated text' } })
          ).not_to render_template :update
        end
      end

      context 'when admin' do
        before do
          request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in admin
          patch :update, params: { id: book_bibliography, book_bibliography: { title: 'updated text' } }
        end

        it 'assigns book_bibliography to @book_bibliography' do
          expect(assigns(:book_bibliography)).to eql book_bibliography
        end

        it 'updates book_bibliography' do
          book_bibliography.reload
          expect(book_bibliography.title).to eql('updated text')
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:book_bibliography) { create(:book_bibliography, user: user) }
    let!(:other_book_bibliography) { create(:book_bibliography) }

    context 'when user' do
      context 'when own book_bibliography' do
        before do
          request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in user
        end

        it 'assigns book_bibliography to @book_bibliography' do
          delete :destroy, params: { id: book_bibliography }
          expect(assigns(:book_bibliography)).to eql book_bibliography
        end

        it 'destroys book_bibliography' do
          expect do
            delete(:destroy, params: { id: book_bibliography })
          end.to change(BookBibliography, :count).by(-1)
        end

        it 'renders index' do
          expect(
            delete(:destroy, params: { id: book_bibliography })
          ).to render_template :index
        end
      end

      context "when other user's book_bibliography" do
        before do
          request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in user
        end

        it 'does not destroy book_bibliography' do
          expect do
            delete(:destroy, params: { id: other_book_bibliography })
          end.not_to change(BookBibliography, :count)
        end

        it 'does not render destroy template' do
          expect(
            delete(:destroy, params: { id: other_book_bibliography })
          ).not_to render_template :index
        end
      end

      context 'when admin' do
        before do
          request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in admin
        end

        it 'assigns book_bibliography to @book_bibliography' do
          delete(:destroy, params: { id: book_bibliography })
          expect(assigns(:book_bibliography)).to eql book_bibliography
        end

        it 'destroys book_bibliography' do
          expect do
            delete(:destroy, params: { id: book_bibliography })
          end.to change(BookBibliography, :count).by(-1)
        end

        it 'renders index' do
          expect(
            delete(:destroy, params: { id: book_bibliography })
          ).to render_template :index
        end
      end
    end
  end
end
