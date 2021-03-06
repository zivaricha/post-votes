class ScoreWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  include Sidekiq::Status::Worker
  sidekiq_options :queue => :default, :backtrace => true, :failures => :true

  recurrence { hourly }

  def perform
    Post.find_in_batches do |group|
      posts_hash = {}
      group.each do |post|
        score = PostScoreCalculator.new(post).calculate(10)
        posts_hash[post.id] = {"score": score}
      end

      Post.update(posts_hash.keys,posts_hash.values)
    end

    cache_keys = $redis.keys("cache:TopPosts*")
    $redis.del cache_keys if cache_keys.present?
  end
end
