FactoryBot.define do
    factory :activity do
        id { 2 }
        level { "普通" }
        index { 1.75 }
        activity { "座位中心の仕事だが、職場内での移動や立位での作業・接客等、通気・買い物での歩行、家事、軽いスポーツのいずれかを含む" }
    end
end