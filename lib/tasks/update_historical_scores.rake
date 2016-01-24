desc 'update_historical_scores'
task update_historical_scores: :environment do
    Score.all.order('created_at ASC').each do |score|
        sleep(2)
        @yesterday_score = Score.where(user_id: score.user_id).where(game_id: score.game_id).where(date: (score.date - 1.day)).first
        puts @yesterday_score
        if @yesterday_score.blank?
            puts "the score didn't exist, set it as 1"
            score.streak = 1
        else
            #make sure that score has a streak
            if @yesterday_score.streak.blank?
                #the yesterday score doesn't have a streak
                #set a streak for that score before moving on
                @day_before_yesterday_score = Score.where(user_id: @yesterday_score.user_id).where(game_id: @yesterday_score.game_id).where(date: (@yesterday_score.date - 1.day)).first
                puts "the previous day's score didnt have a streak, so we checked the streak before it"
                if @day_before_yesterday_score.blank?
                    puts "the score before yesterday didn't exist, so yesterday's streak is 1"
                    @yesterday_score.streak = 1
                else
                    puts "the score before yesterday did exist, set the value"
                    @yesterday_score.streak = @day_before_yesterday_score.streak + 1
                end
            end
            puts "at this point, we expect yesterday to have a streak"
            puts "score exists"
            puts "the old streak was:"
            puts @yesterday_score.streak
            score.streak = @yesterday_score.streak + 1
            puts "the new streak is now:"
            puts score.streak
            sleep(1)
        end
        score.save
        sleep(3)
    end
end