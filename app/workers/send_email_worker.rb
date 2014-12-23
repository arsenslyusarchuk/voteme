class SendEmailWorker
  include Sidekiq::Worker
  def perform(poll_id, poll_url)
    VotingMailer.vote_stopped(poll_id, poll_url).deliver
  end
end
