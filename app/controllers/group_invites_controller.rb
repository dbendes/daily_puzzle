class GroupInvitesController < ApplicationController
  before_action :set_group_invite, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin, only: [:show, :edit, :update, :destroy, :index]

  # GET /group_invites
  # GET /group_invites.json
  def index
    @group_invites = GroupInvite.all
  end

  # GET /group_invites/1
  # GET /group_invites/1.json
  def show
  end

  # GET /group_invites/new
  def new
    @group_invite = GroupInvite.new
  end

  # GET /group_invites/1/edit
  def edit
  end

  # POST /group_invites
  # POST /group_invites.json
  def create
    @group_invite = GroupInvite.new(group_invite_params)

    respond_to do |format|
      if @group_invite.save
        #format.html { redirect_to @group_invite, notice: 'Group invite was successfully created.' }
        format.json { render :show, status: :created, location: @group_invite }
      else
        format.html { render :new }
        format.json { render json: @group_invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_invites/1
  # PATCH/PUT /group_invites/1.json
  def update
    puts "inside the update"
    respond_to do |format|

        @group = Group.find(@group_invite.group_id)
        @group.users << User.current
        @group_invite.destroy
        format.html { redirect_to @group, notice: 'Welcome to the group!' }
        format.json { render :show, status: :ok, location: @group_invite }

    end
  end

  # DELETE /group_invites/1
  # DELETE /group_invites/1.json
  def destroy
    @user = User.current
    @group_invite.destroy
    respond_to do |format|
      format.html { redirect_to @user, notice: 'You did not accept the group invite.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_invite
      @group_invite = GroupInvite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_invite_params
      params.require(:group_invite).permit(:email, :group_id)
    end
end
