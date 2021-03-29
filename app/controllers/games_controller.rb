class GamesController < ApplicationController
  before_action :set_game, only: %i[show update destroy]

  # GET /games
  def index
    @games = Game.all
  end

  # GET /games/1
  def show
  end

  # POST /games
  def create
    @game = Game.new

    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render :index
    end
  end

  def update
    @game.play(params[:game][:move])
    redirect_to @game, alert: @game.errors.first&.message
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    redirect_to games_url, notice: 'Game was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end
end
