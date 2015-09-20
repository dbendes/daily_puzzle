class RegistrationsEmailController < Devise::RegistrationsController
    def create
        super
        if @user.persisted? && @user.errors.empty?
            invites = GroupInvite.find_by_email(@user.email)
            if invites
                invites.each do |f|
                    f.group.users << @user
                    f.destroy
                end
            end
            UserMailer.welcome_email(@user).deliver
        end
    end
end