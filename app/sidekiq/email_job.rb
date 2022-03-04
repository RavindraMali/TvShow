class EmailJob
  include Sidekiq::Job

  def perform(*args)
    puts "EmailJob creating"
    sleep 5
    puts "EmailJob created"
  end
end
