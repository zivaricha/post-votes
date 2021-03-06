class Product

  attr_reader :post

  def initialize(post)
    @post = post
  end

  def calculate(days_back_to_consider_new)
    upvotes = @post.votes_count
    score = upvotes
    weight_for_new_posts = 1.5
    score *= weight_for_new_posts if @post.created_at > Time.now - days_back_to_consider_new.minutes.ago
    return score
  end
end
