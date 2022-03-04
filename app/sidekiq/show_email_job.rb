class ShowEmailJob
  include Sidekiq::Job

  def perform(*args)
    @shows = Show.where(start_time: 30.minutes.from_now.beginning_of_minute)
    @shows.each do |show|
        users = show.favoritors
        users.each do |user|
          ShowNotificationMailer.notification(show, user).deliver_later
        end
    end
  end
end
