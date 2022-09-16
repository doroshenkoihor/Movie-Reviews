class Review < ApplicationRecord
	belongs_to :user
	belongs_to :movie

	after_create :update_movie_rating

    def update_movie_rating
      movie.update_average_rating
    end
end
