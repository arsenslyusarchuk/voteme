class SendEmailWorker
  include Sidekiq::Worker
  def perform(poll_id)
    VotingMailer.vote_stopped(poll_id).deliver
  end
end
