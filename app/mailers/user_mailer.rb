class UserMailer < ApplicationMailer
    def welcome_email(user)
        @user = user
        @url  = 'http://dailypuzzl.es'
        mail(to: @user.email, subject: 'Welcome to DailyPuzzl.es')
    end
end
