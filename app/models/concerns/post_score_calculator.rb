class PostScoreCalculator

  attr_reader :post

  def initialize(post, params={})
    @post = post
  end

  def calculate(minutes_back_to_consider_new)
    upvotes = @post.votes_count
    score = upvotes
    weight_for_new_posts = 1.5
    score *= weight_for_new_posts if @post.created_at > Time.now - minutes_back_to_consider_new.minutes
    return score
  end
end
