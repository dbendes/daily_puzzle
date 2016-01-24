desc 'update_historical_scores'
task update_historical_scores: :environment do
    Score.all.order('created_at ASC').each do |score|
        new_score = Score.where(user_id: score.user_id).where(game_id: score.game_id).where(date: (score.date - 1.day))
        if new_score.exists?
            score.streak = new_score.streak + 1
        else
            score.streak = 1
        end
        score.save
    end
end