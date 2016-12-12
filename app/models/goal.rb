class Goal < ActiveRecord::Base
  validates :user, :description, presence: true
  validates :status, inclusion: { in: ["COMPLETE", "INCOMPLETE"] }
  validates :private, inclusion: { in: ["PRIVATE", "PUBLIC"] }


  belongs_to :user

  has_many :comments
end
