class UsersController < ApplicationController
    respond_to :html
    before_action :authenticate_user!

    def show
        @user = User.find(params[:id])
        @games = Game.all
        @groupinvites = GroupInvite.where(email: User.current.email)
        @email_preference = @user.email_preference
    end
end