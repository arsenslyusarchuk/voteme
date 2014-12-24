class PollListSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :stopped

  def created_at
    object.created_at.strftime("%-d %b %Y")
  end
end
