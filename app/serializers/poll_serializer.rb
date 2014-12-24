class PollSerializer < ActiveModel::Serializer
  delegate :current_user, to: :scope
  attributes :id, :title, :description, :user_id, :poll_type, :created_at, :user_voted, :voting_results, :can_delete, :stopped, :can_stop, :total_users_voted

  has_many :answers

  def created_at
    object.created_at.strftime("%-d %b %Y")
  end

  def user_voted
    user_has_voted
  end

  def voting_results
    if user_has_voted
      object.answers.joins(:users).group("answers.id").count.to_a
    end
  end

  def total_users_voted
    if user_has_voted
      User.select(:id).uniq.joins(:answers).where("answers.id IN (?) ", object.answers.pluck(:id)).map(&:id)
    end
  end

  def can_delete
    Ability.new(current_user).can?(:destroy, object)
  end

  def can_stop
    object.answers.joins(:users).any? && can_delete && !object.stopped
  end

  private

  def user_has_voted
    current_user.answers.where('answers.poll_id = ?', object.id).any? ? true : false
  end
end
