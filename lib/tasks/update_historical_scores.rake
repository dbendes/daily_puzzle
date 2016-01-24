desc 'update_historical_scores'
task update_historical_scores: :environment do
    Score.all.order('created_at ASC').each do |score|
        sleep(2)
        @new_score = Score.where(user_id: score.user_id).where(game_id: score.game_id).where(date: (score.date - 1.day)).first
        puts @new_score
        if @new_score.blank?
            puts "the score didn't exist, set it as 1"
            score.streak = 1

        else
            puts "score exists"
            puts "the current streak (before new value set) is:"
            puts score.streak
            puts "the old streak was:"
            puts @new_score.streak
            score.streak = @new_score.streak + 1
            puts "the new streak is now:"
            puts score.streak
            sleep(1)


        end
        score.save
    end
end