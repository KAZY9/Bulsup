require 'rails_helper'

RSpec.describe "Mainpages", type: :request do
  describe "GET /top" do
    before { get '/top' }

    it 'レスポンスコードが200である' do
      expect(response).to have_http_status(:ok)
    end

    it 'topテンプレートをレンダリングする' do
      expect(response).to render_template :top
    end

    it '新しいinformationオブジェクト、Activity Allがビューに渡される' do
      expect(assigns(:user_info)).to be_a_new Information
      expect(assigns(:activity_levels)).to be_all Activity
    end
  end

  describe "POST /calculate", type: :request do
    context '正しいインフォーメーション情報が渡ってきた場合' do
      let(:user) { FactoryBot.create(:user) }
      let(:valid_params) do
        { information: {
          age: '25',
          sex: '男性',
          weight: '65',
          height: '171',
          activity_level: '2',
          start_date: '2023-10-23',
          end_date: '2023-10-31',
          weight_to_gain: '1.0'
        }}
      end

      before { sign_in user }

      it 'インフォーメーションが１つ増えている' do
        expect { post '/calculate', params: valid_params }.to change(Information, :count).by(1)
      end

      it 'resultsページにリダイレクトされる' do
        expect(post '/calculate', params: valid_params).to redirect_to(results_path(id: assigns(:user_info).id))
      end
    end
  end

  describe "GET /results" do
    let(:user) { FactoryBot.create(:user) }
    let(:information) { FactoryBot.create(:information) }
    let(:activity) { FactoryBot.create(:activity) }

    before do
      sign_in user
      @activity = activity
      @user_info = information
    end

    context 'パラメーターが提供された場合' do  
      it 'レスポンスコードが200である' do
        get '/results', params: { id: @user_info.id }
        expect(response).to have_http_status(:ok)
      end

      it '指定されたIDの情報が取得され、変数に正しい値が設定される' do
        get '/results', params: { id: information.id }
        expect(assigns(:user_info)).to eq(information)
        expect(assigns(:formatted_start_date)).to eq(information.change_date_format(information.start_date))
        expect(assigns(:formatted_end_date)).to eq(information.change_date_format(information.end_date))
      end
    end
    
    context '正しい計算結果がセットされる' do
      let(:information) { FactoryBot.create(:information) }

      before do
        get '/results', params: { id: @user_info.id }
      end

      it 'アクティビティが正しく取得される' do
        expect(assigns(:activity)).to eq(Activity.find_by(id: @user_info.activity_level))
      end

      it '基礎代謝量が正しく計算される' do
        expect(assigns(:basal_metabolism)).to eq(@user_info.calorie_cunsumption_calculate(@user_info.weight, @user_info.height, @user_info.age, @user_info.sex))
      end

      it '総消費カロリーが正しく計算される' do
        @basal_metabolism = @user_info.calorie_cunsumption_calculate(@user_info.weight, @user_info.height, @user_info.age, @user_info.sex)
        expect(assigns(:calorie_consumption)).to eq((@basal_metabolism * @activity.index).round(0))
      end

      it '1日に摂取すべき余剰カロリーが正しく計算される' do
        @results = @user_info.calculate_calorie_intake(@user_info.start_date, @user_info.end_date, @user_info.weight_to_gain)
        expect(@results).to eq({:days_differences=>10, :surplus_calorie=>720.0})
      end

      it '1日に摂取すべき総カロリーが正しく計算される' do
        @basal_metabolism = @user_info.calorie_cunsumption_calculate(@user_info.weight, @user_info.height, @user_info.age, @user_info.sex)
        @calorie_consumption = (@basal_metabolism * @activity.index).round(0)
        @results = @user_info.calculate_calorie_intake(@user_info.start_date, @user_info.end_date, @user_info.weight_to_gain)
        @calorie_intake = (@results[:surplus_calorie] + @calorie_consumption).round(0)
        expect(@calorie_intake).to eq(3601)
      end
    end
  end

  describe "POST /suggest_meal", type: :request do
    let(:user) { FactoryBot.create(:user) }
    let(:information) { FactoryBot.create(:information) }
    let(:activity) { FactoryBot.create(:activity) }

    before do
      sign_in user
      @user_info = information
      @activity = activity
    end

    context 'パラメータが提供された場合' do
      let(:params) {
        { information: { information_id: @user_info.id } }
      }
      it 'Mealが1つ増えている' do
        expect { post '/suggest_meal', params: params, xhr: true }.to change(Meal, :count).by(1)
      end
    end
  end
end

