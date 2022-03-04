class CustomeJob
  
  def perform(*args)
      batch = Sidekiq::Batch.new
      batch.description = "Batch Description of Customer Job"
      batch.on(:success, CustomeJob::Created,{ "custome_id" => 101})  
      batch.jobs do
        5.times { EmailJob.perform_async }
      end
  end

  class Created
    def on_success(status, options)
        puts "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
        puts status
        puts "\tcustome job created"
    end
  end
end
