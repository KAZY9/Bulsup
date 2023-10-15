require 'ruby/openai'
class MainpagesController < ApplicationController

    def top
        @activity_levels = Activity.all
        @user_info = Information.new
    end

    def calculate
        @activity_levels = Activity.all
        @user_info = Information.new(calorie_params)
        if @user_info.save
            redirect_to results_path(id: @user_info.id)
        else
            render :top, status: :unprocessable_entity
        end

    end

    def results
        if params[:id].present?
            @user_info = Information.find(params[:id])
            @formatted_start_date = @user_info.change_date_format(@user_info.start_date)
            @formatted_end_date = @user_info.change_date_format(@user_info.end_date)
            calculate_calorie
        end
    end

    def suggest_meal
        @user_info = Information.find(params[:information][:information_id])
        calculate_calorie
        @query = "体重増量のために合計" + @calorie_intake.to_s + "kcalになる1日の食事内容を量g、個数、カロリーなども含めて正確に具体的に教えてください。アルコールは含めないでください。"
        set_chatgpt
        @meal_suggestion = Meal.create(information_id: @user_info.id, content: @chats)
    end

    private

    def set_chatgpt
        @client = OpenAI::Client.new(
            access_token: ENV['OPENAI_ACCESS_TOKEN'],
            timeout: 60
        )
        response = @client.chat(
            parameters: {
                model: "gpt-3.5-turbo",
                messages: [{role: "user", content: @query}],
            })
        puts response
        @chats = response.dig("choices", 0, "message", "content")
    end

    def calculate_calorie
        @activity = Activity.find_by(id: @user_info.activity_level)
        @basal_metabolism = @user_info.calorie_cunsumption_calculate(@user_info.weight, @user_info.height, @user_info.age, @user_info.sex)
        @calorie_consumption = (@basal_metabolism * @activity.index).round(0)
        @results = @user_info.calculate_calorie_intake(@user_info.start_date, @user_info.end_date, @user_info.weight_to_gain)
        @calorie_intake = (@results[:surplus_calorie] + @calorie_consumption).round(0)
    end

    def calorie_params
        params.require(:information).permit(
            :age,
            :sex,
            :weight, 
            :height,
            :activity_level,
            :start_date,
            :end_date,
            :weight_to_gain
        )
    end
end
