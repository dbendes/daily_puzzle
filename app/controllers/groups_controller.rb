class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /groups
  # GET /groups.json
  def index
    if params[:search]
      @groups = Group.search(params[:search]).sort_by {|group| group.members}.reverse
    else
      @groups = nil
    end
    @my_groups = User.current.groups
    @membership = Membership.new
    @user = User.current
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
        @group = Group.find(params[:id])
        @users = @group.users.order(last: :asc)
        @user = User.current
        @games = Game.all
        if @users.where(id: current_user.id).empty?
          @membership = Membership.new
        else
          @membership = Membership.where(user_id: current_user.id).where(group_id: @group.id)
        end
        @groupinvites_notuser = GroupInvite.joins("INNER JOIN users ON users.email = group_invites.email").where("users.first" => nil).where(group_id: @group.id)
        @membershipinvites =  Membership.joins(:user).where("users.first" => nil).where(group_id: @group.id)
        @groupinvites = GroupInvite.joins("INNER JOIN users ON users.email = group_invites.email").where.not("users.first" => nil).where(group_id: @group.id)
        #User.where(first: nil).joins(:groups).where("groups.id = ?", @group.id)
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    @user = User.current

    respond_to do |format|
      if @group.save
        @group.users << @user
        @membership = @group.memberships.where(user_id: User.current.id).first
        @membership.role = 2
        @membership.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :checkbox_value, :private)
    end
end
