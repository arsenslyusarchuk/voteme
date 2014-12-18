user = User.first
20.times do |t|
  @poll = Poll.new(
    user_id: user.id,
    title: "Heading_#{t}",
    description: 'Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui.',
    poll_type: 'radio'
  )

  @poll.answers.build([{title: 'Yes'}, {title: 'No'}])
  @poll.save
end
