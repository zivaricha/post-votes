class AddScoreToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :score, :float, default: 0
  end
end
