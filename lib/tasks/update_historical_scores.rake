desc 'update_historical_scores'
task update_historical_scores: :environment do
    Score.all.order('created_at ASC').each do |score|
        sleep(2)
        @new_score = Score.where(user_id: score.user_id).where(game_id: score.game_id).where(date: (score.date - 1.day))
        if @new_score.exists?
            puts "score exists"
            puts "the old streak was:"
            puts @score.streak
            score.streak = @new_score.streak + 1
            sleep(1)
        else
            puts "the score didn't exist, set it as 1"
            score.streak = 1
        end
        score.save
    end
end