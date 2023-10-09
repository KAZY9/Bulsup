class Calorie < ApplicationRecord
    validates :sex, presence: true
    validates :age, presence: true
    validates :height, presence: true
    validates :weight, presence: true
    validates :activity_level, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :weight_to_gain, presence: true
    validate :start_date_must_be_before_end_date

    def start_date_must_be_before_end_date
        if start_date.present? && end_date.present? && start_date >= end_date
            errors.add(:start_date, "は目標到達日よりも前の日付で入力してください")
        end
    end

    def calorie_cunsumption_calculate(weight, height, age, sex)
        if sex == "男性"
            @calorie_consumption = (66.47 + 13.75 * weight.to_f + 5.00 * height.to_f - 6.76 * age.to_f).round(0)
            return @calorie_consumption
        elsif sex =="女性"
            @calorie_consumption = (665.10 + 9.56 * weight.to_f + 1.84 * height.to_f - 4.68 * age.to_f).round(0)
        end
    end

    def calculate_calorie_intake(start_date, end_date, weight_to_gain)
        days_differences = (end_date - start_date).to_i
        surplus_calorie = (7200 * weight_to_gain) / days_differences
      
        result = {
          days_differences: days_differences,
          surplus_calorie: surplus_calorie
        }
      
        return result
    end

    def localized_day_of_week(day)
        %w[日 月 火 水 木 金 土][day.wday]
    end

    def change_date_format(date)
        formatted_date = date.strftime("%Y/%m/%d(#{localized_day_of_week(date)})")
        return formatted_date
    end
end
