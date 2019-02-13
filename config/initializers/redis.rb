require 'redis'
require 'redis-namespace'

redis_url = ENV["REDISCLOUD_URL"] || "redis://127.0.0.1:6379/0"
redis_conn = Redis.new(url: redis_url,
					   driver: :hiredis)
					   # :driver => :synchrony)

named_space = ((ENV["CANONICAL_HOST"].present? ?  ENV["CANONICAL_HOST"] : Rails.env)+("-keys")).to_sym

$redis = Redis::Namespace.new(named_space, redis: redis_conn)
$redis = $redis.redis

REDIS_TTL = 1000 * 60 * 10 # = 10 minutes
