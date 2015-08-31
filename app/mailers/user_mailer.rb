class UserMailer < ApplicationMailer

    def welcome_email(user)
        @user = user
        mail(to: user.email, subject: 'Welcome to DailyPuzzl.es!')
    end
    def request_to_join_group_email(membership)
        @group = Group.find(membership.group_id)
        @user = User.find(membership.user_id)
        @admin = Membership.where(role: 2).where(group_id: @group.id).first.user
        mail(to: @admin.email, subject: "Daily Puzzles: Request to join " + @group.name)
    end

    protected
    def subject_for(key)
        if key.to_s == 'invitation_instructions'
            puts "notsuper"
            puts "notsuper"
            puts "notsuper"
            puts "notsuper"
            puts "notsuper"
            puts "notsuper"
            puts "notsuper"
            puts "notsuper"
            I18n.t(resource.invited_by.full_name + " Invited You To Play the Daily Puzzles!")
        else
            puts "super"
            puts "super"
            puts "super"
            puts "super"
            puts "super"
            puts "super"
            puts "super"
            puts "super"
            puts "super"
            puts "super"
            return super
        end
    end

end
