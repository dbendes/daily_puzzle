desc 'daily_email'
task daily_email: :environment do
    @users = User.where(daily: true)
    @users.each do |user|
        UserMailer.daily_email(user).deliver
    end
end