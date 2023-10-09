class MainpagesController < ApplicationController
    def top
        @activity_levels = Activity.all
        @user_info = Calorie.new
    end

    def calculate
        @activity_levels = Activity.all
        @user_info = Calorie.new(calorie_params)
        if @user_info.save
            redirect_to results_path(id: @user_info.id)
        else
            render :top, status: :unprocessable_entity
        end
    end

    def results
        @user_info = Calorie.find(params[:id])
        @formatted_start_date = @user_info.change_date_format(@user_info.start_date)
        @formatted_end_date = @user_info.change_date_format(@user_info.end_date)
        @activity = Activity.find_by(id: @user_info.activity_level)
        @basal_metabolism = @user_info.calorie_cunsumption_calculate(@user_info.weight, @user_info.height, @user_info.age, @user_info.sex)
        @calorie_consumption = (@basal_metabolism * @activity.index).round(0)
        @result = @user_info.calculate_calorie_intake(@user_info.start_date, @user_info.end_date, @user_info.weight_to_gain)
        @calorie_intake = (@result[:surplus_calorie] + @calorie_consumption).round(0)
    end

    private

    def calorie_params
        params.require(:calorie).permit(
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
