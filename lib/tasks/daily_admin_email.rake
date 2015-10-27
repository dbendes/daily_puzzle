desc 'daily_admin_email'
task daily_admin_email: :environment do
    @users = User.where(admin: true)
    @users.each do |admin|
        UserMailer.daily_email(admin).deliver
    end
end