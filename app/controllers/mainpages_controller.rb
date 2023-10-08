class MainpagesController < ApplicationController
    def top
        @activity_levels = Activity.all
        @user_info = Calorie.new
    end

    def calculate
        @user_info = Calorie.new(calorie_params)
        if @user_info.save
            redirect_to results_path(id: @user_info.id)
        else
            render :top
        end
    end

    def results
        @user_info = Calorie.find(params[:id])
        @activity = Activity.find_by(id: @user_info.activity_level)
        @basal_metabolism = @user_info.calorie_cunsumption_calculate(@user_info.weight, @user_info.height, @user_info.age, @user_info.sex)
        @calorie_consumption = @basal_metabolism * @activity.index
    end

    private

    def calorie_params
        params.permit(
            :age,
            :sex,
            :weight, 
            :height,
            :activity_level
        )
    end
end
