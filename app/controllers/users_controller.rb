class UsersController < ApplicationController
    respond_to :html
    def show
        @user = current_user
        @games = Game.all
        respond_with(@user)
    end
end