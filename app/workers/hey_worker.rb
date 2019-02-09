class HeyWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :default, :backtrace => true, :failures => :true

  def perform
    puts 1+1
  end
end
