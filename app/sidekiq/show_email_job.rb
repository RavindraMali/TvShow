class ShowEmailJob
  include Sidekiq::Job

  def perform(*args)
    puts "Email sent to user about their show info"
  end
end
