class RegistrationsEmailController < Devise::RegistrationsController
    def create
        super
        if @user.persisted? && @user.errors.empty?
            UserMailer.welcome_email(@user).deliver
        end
    end
end