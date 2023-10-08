class Calorie < ApplicationRecord

    def calorie_cunsumption_calculate(weight, height, age, sex)
        if sex == "男性"
            @calorie_consumption = (66.47 + 13.75 * weight.to_f + 5.00 * height.to_f - 6.76 * age.to_f).round(0)
            return @calorie_consumption
        elsif sex =="女性"
            @calorie_consumption = (665.10 + 9.56 * weight.to_f + 1.84 * height.to_f - 4.68 * age.to_f).round(0)
        end
    end
end
