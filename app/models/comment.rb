class Comment < ActiveRecord::Base
  validates :owner, :body, presence: true

  belongs_to :commentable, polymorphic: true

  belongs_to :owner,
    foreign_key: :user_id,
    class_name: :User
end
