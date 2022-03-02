class ShowNotificationJob
  include Sidekiq::Job

  def perform(show_name)
    puts "Show Name : #{show_name}"
  end
end
