class UsersController < ApplicationController
    respond_to :html
    before_action :authenticate_user!

    def show
        @user = User.find(params[:id])
        @games = Game.all
    end
end