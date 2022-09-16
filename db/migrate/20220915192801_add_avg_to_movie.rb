class AddAvgToMovie < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :avg, :float
  end
end
