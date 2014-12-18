class Answer < ActiveRecord::Base
  belongs_to :poll
  has_and_belongs_to_many :users

  validates :title, presence: true, length: { maximum: 128 }
end
