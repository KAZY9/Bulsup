activities = [["低い", 1.50, "生活の大部分が座位で、静的な活動が中心"],
            ["普通", 1.75, "座位中心の仕事だが、職場内での移動や立位での作業・接客等、通気・買い物での歩行、家事、軽いスポーツのいずれかを含む"], 
            ["高い", 2.00, "移動や立位の多い仕事への従事者、あるいはスポーツ等余暇における活発な運動習慣を持っている"]]

for activity in activities            
    Activity.create!(
        level: activity[0],
        index: activity[1],
        activity: activity[2]
    )
end
