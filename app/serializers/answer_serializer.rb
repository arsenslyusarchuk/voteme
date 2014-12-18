class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :title, :poll_id, :created_at
end
