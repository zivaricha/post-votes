class ScoreWorker
  include Sidekiq::Worker

  def perform
    Post.find_in_batches do |group|
      posts_hash = {}
      group.each do |post|
        score = PostScoreCalculator.new(post).calculate(1)
        posts_hash[post.id] = {"score": score}
      end

      Post.update(posts_hash.keys,posts_hash.values)
    end
  end
end
