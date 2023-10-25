require 'rails_helper'

RSpec.describe Information, type: :model do
  let(:valid_information) {FactoryBot.build(:information)}
  describe 'バリデーションチェック' do

    it "正常な値の場合有効" do
      expect(valid_information).to be_valid
    end

    it "増量開始日が増量終了日より遅い場合は無効" do
      invalid_information = FactoryBot.build(:information, start_date: '2023-10-31', end_date: '2023-10-21')
      expect(invalid_information).not_to be_valid
    end

    it "必要な属性が欠落している場合は無効" do
      invalid_attributes = %i[sex age height activity_level start_date end_date weight_to_gain]

      invalid_attributes.each do |attr|
        information = FactoryBot.build(:information)
        information[attr] = nil
        expect(information).not_to be_valid
      end
    end
  end

  describe '消費カロリー計算' do
    it '男性の消費カロリー計算の値が正常' do
      expect(valid_information.calorie_cunsumption_calculate(65, 171, 25, "男性")).to eq (1646)
    end

    it '女性の消費カロリー計算の値が正常' do
      expect(valid_information.calorie_cunsumption_calculate(65, 171, 25, "女性")).to eq (1484)
    end
  end

  describe '摂取カロリー計算' do
    it '摂取カロリー計算の値が正常' do
      result = valid_information.calculate_calorie_intake(valid_information.start_date, valid_information.end_date, valid_information.weight_to_gain)
      expect(result[:days_differences]).to eq (10)
      expect(result[:surplus_calorie]).to eq (720.0)
    end
  end
  
  describe '日付フォーマット' do
    it '日付が"yyyy/mm/dd(曜日)のフォーマットに変換される' do
      expect(valid_information.change_date_format(valid_information.start_date)).to eq ('2023/10/21(土)')
    end
  end
end


