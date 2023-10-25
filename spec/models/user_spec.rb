require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_user) {FactoryBot.build(:user)}

  describe 'バリデーションチェック' do
    it "正しい属性を持つ場合は有効" do
      expect(valid_user).to be_valid
    end

    it "アルファベットだけのパスワードの場合は無効" do
      invalid_user = FactoryBot.build(:user, password: "weakpassword", password_confirmation: "weakpassword")
      expect(invalid_user).not_to be_valid
    end

    it "８文字未満のパスワードの場合は無効" do
      invalid_user = FactoryBot.build(:user, password: "pas1!w", password_confirmation: "pas1!w")
      expect(invalid_user).not_to be_valid
    end

    it "name属性が空の場合は無効" do
        invalid_user = FactoryBot.build(:user, name: nil)
        expect(invalid_user).not_to be_valid
    end

    it "email属性が空の場合は無効" do
      invalid_user = FactoryBot.build(:user, email: nil)
      expect(invalid_user).not_to be_valid
    end
  end

  describe 'Userオブジェクトのupdate' do
    it 'name属性の値を変更可能' do
      valid_user.name = 'Alice'
      expect(valid_user.name).to eq ("Alice")
    end

    it 'email属性の値を変更可能' do
      valid_user.email = 'Alice@example.com'
      expect(valid_user.email).to eq("Alice@example.com")
    end
  end
end
