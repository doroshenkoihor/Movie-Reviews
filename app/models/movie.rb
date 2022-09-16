class Movie < ApplicationRecord
	has_many :reviews, dependent: :destroy

	has_one_attached :image

	def update_average_rating
	  avg = 0
	  
	  if reviews.present?
        avg = reviews.average(:rating).round(2)
      end

      update(avg: avg)
	end
end