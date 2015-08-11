class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :edit, :update, :destroy]

  # GET /scores
  # GET /scores.json
  def index
    @scores = Score.all
  end

  # GET /scores/1
  # GET /scores/1.json
  def show
  end

  # GET /scores/new
  def new
    @score = Score.new
  end

  # GET /scores/1/edit
  def edit
  end

  # POST /scores
  # POST /scores.json
  def create

    @user = current_user
    @score = @user.scores.new(score_params)
    @games = Game.all
    score_string = score_params[:value]
    score_array = score_string.split
    score_float = 0.0


    score_array = score_array.map {|x| Float(x) rescue nil }.compact.reverse
    if score_array.length == 1
      score_float = (score_array[0]*100).round() / 100
    else
      #reverse the score array so the lowest score, i.e. seconds, is first

      score_array.each_with_index do | score, index |
        score_float += ((score) * ( (60)**(index) ) )
      end
    end
    @score.value = score_float

    respond_to do |format|
      if @score.save
        format.html { redirect_to root_path, notice: 'Thanks for playing!' }
        format.json { render :show, status: :created, location: @score }
      else
        format.html { redirect_to games_path, notice: "Sorry, you've already logged a score today." }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scores/1
  # PATCH/PUT /scores/1.json
  def update
    respond_to do |format|
      if @score.update(score_params)
        format.html { redirect_to @score, notice: 'Score was successfully updated.' }
        format.json { render :show, status: :ok, location: @score }
      else
        format.html { render :edit }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1
  # DELETE /scores/1.json
  def destroy
    @score.destroy
    respond_to do |format|
      format.html { redirect_to scores_url, notice: 'Score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_params
      params.require(:score).permit(:value, :game_id, :user_id, :date)
    end
end
