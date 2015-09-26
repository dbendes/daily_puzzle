class WikiracesController < ApplicationController
  before_action :set_wikirace, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin

  # GET /wikiraces
  # GET /wikiraces.json
  def index
    @wikiraces = Wikirace.all
  end

  # GET /wikiraces/1
  # GET /wikiraces/1.json
  def show
  end

  # GET /wikiraces/new
  def new
    @wikirace = Wikirace.new
  end

  # GET /wikiraces/1/edit
  def edit
  end

  # POST /wikiraces
  # POST /wikiraces.json
  def create
    @wikirace = Wikirace.new(wikirace_params)

    respond_to do |format|
      if @wikirace.save
        format.html { redirect_to @wikirace, notice: 'Wikirace was successfully created.' }
        format.json { render :show, status: :created, location: @wikirace }
      else
        format.html { render :new }
        format.json { render json: @wikirace.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wikiraces/1
  # PATCH/PUT /wikiraces/1.json
  def update
    respond_to do |format|
      if @wikirace.update(wikirace_params)
        format.html { redirect_to @wikirace, notice: 'Wikirace was successfully updated.' }
        format.json { render :show, status: :ok, location: @wikirace }
      else
        format.html { render :edit }
        format.json { render json: @wikirace.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wikiraces/1
  # DELETE /wikiraces/1.json
  def destroy
    @wikirace.destroy
    respond_to do |format|
      format.html { redirect_to wikiraces_url, notice: 'Wikirace was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wikirace
      @wikirace = Wikirace.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wikirace_params
      params.require(:wikirace).permit(:start, :end, :racedate, :start_description, :end_description)
    end
end
