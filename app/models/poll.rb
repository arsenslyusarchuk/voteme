class Poll < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers

  validates :poll_type, inclusion: %w(radio checkbox)
  validates :title, presence: true, length: { maximum: 128 }
  validates :description, presence: true, length: { maximum: 256 }

  scope :search, ->(query) do
    joins(:user).where("LOWER(polls.title) LIKE LOWER(?) OR LOWER(polls.description) LIKE LOWER(?) ", "%#{query}%", "%#{query}%")
  end
  scope :order_by_id, -> (dir) {order("polls.id #{dir}")}
end
