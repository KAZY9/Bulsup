require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe 'POST /guest_sign_in', type: :request do
    it 'ゲストユーザーのオブジェクトができる' do
      expect { post '/guest_sign_in' }.to change(User, :count).by(1)
    end
    it 'ゲストユーザーの削除はできない' do
      post '/guest_sign_in'
      expect { delete '/users' }.to change { User.count }.by(0)
    end
    it 'ゲストユーザーの情報は更新できない' do
      post '/guest_sign_in'
      guest = User.find_by(email: 'guest@example.com')
      original_name = guest.name
      patch user_registration_path(guest), params: { user: { name: "John" } }
      expect(guest.reload.name).to eq(original_name)
    end
  end
end
