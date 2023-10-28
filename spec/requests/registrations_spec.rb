require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  describe "GET /sign_up" do
    before { get '/sign_up' }

    it 'レスポンスが正常である' do
      expect(response).to have_http_status(:ok)
    end

    it 'topテンプレートをレンダリングする' do
      expect(response).to render_template :new
    end

    it '新しいUserオブジェクトがビューに渡される' do
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe "POST /sign_up/complete" do
    context '正しいユーザー情報が渡ってきた場合' do
      let(:valid_params) do
        { user: {
          name: 'John',
          email: 'John@example.com',
          password: 'Passw0rd1!',
          password_confirmation: 'Passw0rd1!',
        }}
      end

      it 'ユーザーが１つ増えている' do
        expect { post '/sign_up/complete', params: valid_params }.to change(User, :count).by(1)
      end

      it 'resultsページにリダイレクトされる' do
        expect(post '/sign_up/complete', params: valid_params).to redirect_to(sign_up_complete_path)
      end
    end
  end

  describe "GET /mypage/edit" do
    context 'ユーザーがログインしている場合' do
      let(:user) { FactoryBot.create(:user) }

      before do
        sign_in user
        get '/mypage/edit'
      end

      it 'レスポンスが正常である' do
        expect(response).to have_http_status(:ok)
      end

      it 'editテンプレートをレンダリングする' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'PUT /users', type: :request do
    context 'ユーザーがログインしている場合' do
      let(:user) { FactoryBot.create(:user) }

      before do
        sign_in user
        get '/mypage/edit'
      end

      it 'ユーザーの名前を変更する' do
        user.update(name: 'Alice')
        expect(user.name).to eq('Alice')
      end

      it 'ユーザーのパスワードを変更する' do
        user.update(password: 'Password1!', password_confirmation: 'Password1!')
        expect(user.password).to eq('Password1!')
        expect(user.password_confirmation).to eq('Password1!')
      end
    end
    context 'ユーザーがログインしていない場合' do
      it '会員情報編集画面に遷移できない' do
        get '/mypage/edit'
        expect(response).to redirect_to '/users/sign_in'
      end
      it '会員情報を更新できない' do
        put '/users'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'DELETE /users', type: :request do
    context 'ユーザーがログインしている場合' do
      let(:user) { FactoryBot.create(:user) }
      before { sign_in user}
      it '退会ボタンを押すとユーザーが１つ減る' do
        expect { delete '/users' }.to change { User.count }.by(-1)
      end
    end
    context 'ユーザーがログインしていない場合' do
      it '退会ボタンを押してもユーザーが減らない' do
        expect { delete '/users' }.to change { User.count }.by(0)
      end
    end
  end
end
