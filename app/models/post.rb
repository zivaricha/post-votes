class Post < ApplicationRecord
  attribute :votes_count

  def upvote
    self.votes_count += 1
  end

  def downvote
    self.votes_count -= 1 if self.votes_count > 0
  end
end
