class EmailSender
  @queue = :emails_queue

  def self.perform(params)
    #code to send out emails
  end
end