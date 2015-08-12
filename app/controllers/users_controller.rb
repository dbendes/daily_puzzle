class UsersController < ApplicationController
    respond_to :html
    def show
        @user = User.find(params[:id])
        @games = Game.all
    end
end