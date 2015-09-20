class UserMailer < ApplicationMailer

    def welcome_email(user)
        @user = user
        mail(to: user.email, subject: 'Welcome to DailyPuzzl.es!')
    end
    def request_to_join_group_email(membership)
        @group = Group.find(membership.group_id)
        @user = User.find(membership.user_id)
        if Membership.where(role: 2).where(group_id: @group.id).first.blank?
        else
            @admin = Membership.where(role: 2).where(group_id: @group.id).first.user
            mail(to: @admin.email, subject: "Daily Puzzles: Request to join " + @group.name)
        end
    end

    def group_invitation(user, group)
        @group = group
        @user = user
        @admin = @group.memberships.where(role: 2).first.user
        mail(to: @user.email, subject: "Daily Puzzles: Invitation to join " + @group.name)
    end

    protected
    def subject_for(key)
        if key.to_s == 'invitation_instructions'
            resource.invited_by.full_name + " Invited You To Play the Daily Puzzles!"
        else
            return super
        end
    end

end
