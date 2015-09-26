class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:show, :edit, :new, :destroy, :index]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
    if membership_params[:user_id].blank?
      @user = current_user
    else
       @user = User.find(membership_params[:user_id])

    end
    @membership = @user.memberships.new(membership_params)
    @group = @membership.group
    if @group.private == true
      @membership.role = 1
    else
      @membership.role = 0
    end

    respond_to do |format|
      if @membership.save
        format.html { redirect_to @group, notice: 'Membership was successfully created.' }
        format.json { render :show, status: :created, location: @membership }
      else
        format.html { render :new }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    old_role = @membership.role
    @membership.role = 0
    @group = @membership.group
    respond_to do |format|
      if @membership.update(membership_params)
        if old_role == 1
        else
          format.html { redirect_to @group, notice: 'Membership was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @group = @membership.group
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to @group, notice: 'Membership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:role, :group_id, :user_id)
    end
end
