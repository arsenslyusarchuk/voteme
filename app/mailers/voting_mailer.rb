class VotingMailer < MandrillMailer::TemplateMailer
  default from: 'info@votemee.herokuapp.com'

  def vote_stopped poll_id, poll_url
    total_votes = 0
    poll = Poll.find(poll_id)
    answers = poll.answers.joins(:users).group("answers.title").count.to_a
    answers.each do |a|
      total_votes+=a[1]
    end
    answers.each do |a|
      a[2] = sprintf('%.2f', (a[1].to_f/total_votes.to_f)*100)
    end
    receivers = User.select(:email).uniq.joins(:answers).where("answers.id IN (?) ", poll.answers.pluck(:id)).map(&:email)

    mandrill_mail(
      template: 'vote-stopped',
      template_name: 'vote-stopped',
      subject: "Voting has been stopped",
      to: receivers,
      vars: {
        'POLL_TITLE' => poll.title,
        'POLL_DESCRIPTION' => poll.description,
        'ANSWERS' => answers,
        'TOTAL_VOTES' => total_votes,
        'WEBSITE_URL' => poll_url
      },
      important: true,
      inline_css: true
    )
  end
end
