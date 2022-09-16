class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  
  def index
    if params[:category].present?
      @movies = Movie.where(category: params[:category]).paginate(page: params[:page], per_page: 3)
      @categories = Movie.pluck(:category).uniq
    else
      @movies = Movie.paginate(page: params[:page], per_page: 3)
    end
  end

  def show
    @reviews = Review.where(movie_id: @movie.id).order("created_at DESC")
   
    @avg_review = @movie.avg
  end

  def new
    @movie = Movie.new
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to movies_url, notice: "Movie was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :description, :category, :rating, :image)
    end
end
