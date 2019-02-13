class Post < ApplicationRecord
  attribute :votes_count

  def upvote
    self.votes_count += 1
  end

  def downvote
    self.votes_count -= 1 if self.votes_count > 0
  end

  def self.get_top_posts(params)
    Rails.cache.fetch("TopPosts|page=#{params[:page].present? ? params[:page] : 1}", expires_in: 5.minutes) {
      posts = Post.all.order("score desc").paginate(:page => params[:page], :per_page => 3).select(:id, :body, :votes_count, :score)
      posts.to_a
    }
  end
end
