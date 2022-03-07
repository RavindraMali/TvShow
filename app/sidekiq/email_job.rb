class EmailJob
  include Sidekiq::Job

  def perform(id)
    
    puts "EmailJob creating #{id}" 
    sleep 5
    puts "EmailJob created #{id}"
  end
end
