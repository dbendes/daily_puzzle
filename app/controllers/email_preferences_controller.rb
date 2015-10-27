class EmailPreferencesController < ApplicationController
  before_action :set_email_preference, only: [:show, :edit, :update, :destroy]

  belongs_to :user

  # GET /email_preferences
  # GET /email_preferences.json
  def index
    @email_preferences = EmailPreference.all
  end

  # GET /email_preferences/1
  # GET /email_preferences/1.json
  def show
  end

  # GET /email_preferences/new
  def new
    @email_preference = EmailPreference.new
  end

  # GET /email_preferences/1/edit
  def edit
  end

  # POST /email_preferences
  # POST /email_preferences.json
  def create
    @email_preference = EmailPreference.new(email_preference_params)
    @user = @email_preference.user
    respond_to do |format|
      if @email_preference.save
        format.html { redirect_to @user, notice: 'Thanks for changing your email preferences.' }
        format.json { render :show, status: :created, location: @email_preference }
      else
        format.html { render :new }
        format.json { render json: @email_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /email_preferences/1
  # PATCH/PUT /email_preferences/1.json
  def update
    @user = @email_preference.user
    respond_to do |format|
      if @email_preference.update(email_preference_params)
        format.html { redirect_to @user, notice: 'Thanks for changing your email preferences.' }
        format.json { render :show, status: :ok, location: @email_preference }
      else
        format.html { render :edit }
        format.json { render json: @email_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /email_preferences/1
  # DELETE /email_preferences/1.json
  def destroy
    @email_preference.destroy
    respond_to do |format|
      format.html { redirect_to email_preferences_url, notice: 'Email preference was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_preference
      @email_preference = EmailPreference.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_preference_params
      params.require(:email_preference).permit(:marketing, :daily, :weekly, :user_id)
    end
end
