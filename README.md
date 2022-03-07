TVSHOW Rails Application

Create TVSHOW Application using rails framework

$rails _6.0.4.4_ new TVSHOW -d postgresql 

-d PostgreSQL will create PostgreSQL default config for you to use.
- _6.0.4.4_  :used to install a specific version of rails 

Move to the TVSHOW folder

$cd TVSHOW

Go to config.database.yml 
Make necessary database options enable by uncommenting them (like username, password, host, database name, port )
Create a new database in PostgreSQL with the same name as the TVSHOW database name which is configured in the database.yml file.
Let’s boot up the rails server by the below command to check everything is going properly or not.

$rails server     OR   $rails s
It should produce below the login terminal
desktop:~/TVSHOW$ rails s
=> Booting Puma
=> Rails 7.0.2.2 application starting in development 
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 5.6.2 (ruby 3.0.0-p0) ("Birdie's Version")
*  Min threads: 5
*  Max threads: 5
*  Environment: development
*          PID: 688126
* Listening on http://127.0.0.1:3000
* Listening on http://[::1]:3000
Use Ctrl-C to stop
Started GET "/" for 127.0.0.1 at 2022-02-25 17:58:15 +0530
Processing by Rails::WelcomeController#index as HTML

If it doesn’t produce this log check with configuration once.
Sometimes error like this 
Webpacker configuration file not found /home/pcs200/TVSHOW/config/webpacker.yml. Please run rails webpacker:install Error: No such file or directory
Solve using  $rails webpacker:install
Re-run the server up command
$rails s 

Backup th code on daily bases

create a new repository on the command line
echo "# TvShow" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/RavindraMali/TvShow.git
git push -u origin main


Install devise Gem for authentication

https://github.com/heartcombo/devise

Add gem into gemfile in application directory

gem 'devise' 

Then run bundle install

Next, you need to run the generator:

$ rails generate devise:install

At this point, a number of instructions will appear in the console. Among these instructions, you'll need to set up the default URL options for the Devise mailer in each environment. Here is a possible configuration for config/environments/development.rb:

config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

In the following command you will replace MODEL with the class name used for the application’s users (it’s frequently User but could also be Admin). This will create a model (if one does not exist) and configure it with the default Devise modules. The generator also configures your config/routes.rb file to point to the Devise controller.

$ rails generate devise MODEL

Then run rails db:migrate

Controller filters and helpers

Devise will create some helpers to use inside your controllers and views. To set up a controller with user authentication, just add this before_action (assuming your devise model is 'User'):

before_action :authenticate_user!

Restart rails server and check your going proper or not.

Error often faced while working with devise ( I faced this while running rails s after devise set up all configurations)
Webpacker::Manifest::MissingEntryError in Devise::Sessions#new 

Webpacker :
 	 
	 Webpacker::Manifest::MissingEntryError in Articles#index  issue get solved after removing below line from /app/views/layouts/application.html.erb
	Solution :
	I have the same issue when I run pre-built rails 6 app.Found out it is because of Webpack version inconsistency in yarn.lock file. Then when I run

	yarn add @rails/webpacker

	bundle update webpacker

Restart rails server and check


Install Active Admin Gem 

https://activeadmin.info/documentation.html

install, simply add the following to your Gemfile:

# Gemfile
gem 'activeadmin'

After updating your bundle, run the installer

rails generate active_admin:install

The installer creates an initializer used for configuring defaults used by Active Admin as well as a new folder at app/admin to put all your admin configurations.

Migrate your db and start the server:

$> rails db:migrate
$> rails server

To add one super admin entry run below command
Active_admin add’s one seed entry in database seed file
$ rails db:seed

Create Channel model in rails 

$ rails g model Channel name:string

Added  unique index to name 

Generated migration file

class CreateChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :channels do |t|
      t.string :name

      t.timestamps
    end
    add_index :channels, :name,                unique: true
  end
end

Migrate this file by running below command

$rails db:migrate


Register Channel model with active admin 
syntax
$ rails generate active_admin:resource
        [MyModelName]

Execute this command
$ rails generate active_admin:resource Channel

It’ll create new tab in active admin navbar with label channel 

Added channels using seeds.rb

channel1 = Channel.create(name: "Star Sports")
channel2 = Channel.create(name: "Ten Sports")
channel3 = Channel.create(name: "ESPN")
channel4 = Channel.create(name: "Jio Sports")

Comment this which are already seeded by seeder 

Create Show model 
rails g model Show name:string start_time:time end_time:time channel_id:integer

channel _id will help us to refer channels

 class CreateShows < ActiveRecord::Migration[6.0]
  def change
    create_table :shows do |t|
      t.string :name
      t.time :start_time
      t.time :end_time
      t.integer :channel_id

      t.timestamps
    end
    add_index :shows, :name,          unique: true
  end
end

Run migrate command

$ rails db:migrate

Create show controller for (web) 
 User can see show list 

Register routes for shows controller

resources:shows

To check routes run command

Rails routes | grep shows

add to favorite functionality  using below gem 

https://github.com/jonhue/acts_as_favoritor 

add this gem in gemfile 
# favoritor 
gem 'acts_as_favoritor'

run bundle install command

-> Or install it yourself as: [option]

$ gem install acts_as_favoritor


If you always want to be up to date fetch the latest from GitHub in your Gemfile:

gem 'acts_as_favoritor', github: 'jonhue/acts_as_favoritor'

Now run the generator:

$ rails g acts_as_favoritor

To wrap things up, migrate the changes into your database:

$ rails db:migrate

Setup

Add acts_as_favoritable to the models you want to be able to get favorited:

class User < ActiveRecord::Base
  acts_as_favoritable
end

class Show < ActiveRecord::Base
  acts_as_favoritable
end

Specify which models can favorite other models by adding acts_as_favoritor:

class User < ActiveRecord::Base
  acts_as_favoritor
end


added will_paginate gem for pagination of records

add gem in gemFile

gem 'will_paginate', '~> 3.3'

run bundle install command

$ bundle install

set per page value for specific model 
example for Show model

class Show
  self.per_page = 5
end

set per_page globally

  WillPaginate.per_page = 10

Basic will_paginate use

## perform a paginated query:
@shows = Show.paginate(page: params[:page])

# or, use an explicit "per page" limit:
Shows.paginate(page: params[:page], per_page: 30)

## render page links in the view:
<%= will_paginate @posts %>

# paginate in Active Record now returns a Relation
Show.where(:name => "shark tank").paginate(:page => params[:page]).order('id DESC')

# the new, shorter page() method
Show.page(params[:page]).order('created_at DESC')

Sidekiq with Radis

Radis
https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-20-04

Command

sudo apt update

sudo apt install redis-server

sudo systemctl restart redis.service

	SideKiq
https://github.com/mperham/sidekiq/wiki/Getting-Started

Command/step

gem 'sidekiq' #add gem

rails generate sidekiq:job hard # create hard(job name) name

bundle exec sidekiq

HardJob.perform_in(5.minutes, 'bob', 5) # add  this line in controller

Cron Job

https://www.rubydoc.info/gems/sidekiq-cron/0.3.0

https://medium.com/geekculture/how-to-create-scheduled-jobs-in-rails-using-sidekiq-cron-dc5dee27eae5

		Note: Start both server(rails c and bundle exec sidekiq OR simply sidekiq on terminal )

-	http://localhost:3000/sidekiq/cron (for sidekiq web ui)

 - add two line in route file before Rails.application.routes.draw do class

require 'sidekiq/web'
require 'sidekiq/cron/web'

into the routes.rb file inclue below code in  do ...end  block


mount Sidekiq::Web => '/sidekiq'  
__________________________________________________________________________


SideKiq-batch
https://github.com/breamware/sidekiq-batch

Add this line to your application's Gemfile:

gem 'sidekiq-batch'

And then execute:

$ bundle

Or install it yourself as:

$ gem install sidekiq-batch


Ensure that you have schedule.yml file into your config/ directory 

If you already have implemented sidekiq or sidekiq-cron gem than this file will be exists into your config/ directory

Or else, you can create it your own
—---------------------------------------------------------------------------------------------
The following content should be there in the file

ShowScheduleEmailJob:                      # job 
   cron: "1 * * * * *"                                 # iteration of job  (every minute)
   class: "ShowEmailJob"                     # job to be perform every minute
—------------------------------------------------------------------------------------------------

Your routes.rb should content below code
# at the top of the page
require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
	# routess
mount Sidekiq::Web => '/sidekiq'
	# rotues
End


Check the below file into your application 
config/initializers/sidekiq.rb

schedule_file = "config/schedule.yml"
if File.exist?(schedule_file) && Sidekiq.server?
   Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end

Sidekiq.strict_args!(false)


To perform the job chunk we will create EmailJob job


Create job using rails sidekiq
$ rails generate sidekiq:job EmailJob

class EmailJob
  include Sidekiq::Job           # include sidekiq job if any already

  def perform(*args)
    puts "EmailJob creating"          # print some message on rails sidekiq console
    sleep 3                                      # make silent the job to observe job processing 
    puts "EmailJob created"           
  end
end



run the below line on root your your application console.

	$ rails generate sidekiq:job  CustomeJob

this will create your job class

app/sidekiq/custome_job.rb

class CustomeJob
  
  def perform(*args)
      batch = Sidekiq::Batch.new			# create new batch
      batch.description = "Batch Description of Customer Job"       # add description for that batch
      batch.on(:success, CustomeJob::Created,{ "custome_id" => 101})  # callback for job suceed
      batch.jobs do                              # iterate batch.jobs 
        5.times { EmailJob.perform_async }            # will create 5 chunks of job EmailJob 
      # EmailJob.perform_async the perform_async is class method to call perform method of                    # Email Job  	
       end
  end           # perform end

  class Created                    # created local class for succeed callback
    def on_success(status, options)
        puts "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
        puts status
        puts "\tcustome job completed"
    end
  end 	   # Created End
end         # CustomeJob End         





Execute the batch 

While working sidekiq , sidekiq-cron and sidekiq-batch below servers boot simultaneously 

$ rails console

$ bundle exec sidekiq            or                sidekiq

And if your application chunking job of web than 
$ rails server


On  $ rails console 
3.0.0 :002 > CustomeJob.new.perform # call the perform method of CustomeJob

CustomeJob is job class

.new will create new instance of CustomeJob class

.perform will call the perform method


Then check the $ bundle exec sidekiq console 
022-03-07T07:59:19.956Z pid=1369617 tid=t365 class=EmailJob jid=ccd2c05da5f08a1302665f0d bid=pza8h2KmvtHT3g INFO: start
2022-03-07T07:59:19.956Z pid=1369617 tid=t36p class=EmailJob jid=d57aa2506a62d65fcc32f582 bid=pza8h2KmvtHT3g INFO: start
2022-03-07T07:59:19.956Z pid=1369617 tid=t385 class=EmailJob jid=867f37b1a06d186a0593c7a5 bid=pza8h2KmvtHT3g INFO: start
EmailJob creating 0
EmailJob creating 3
EmailJob creating 2
EmailJob creating 1
EmailJob creating 4
EmailJob created 0
(called from /home/pcs200/.rvm/gems/ruby-3.0.0/gems/sidekiq-batch-0.1.6/lib/sidekiq/batch.rb:182:in `block in process_successful_job'}
2022-03-07T07:59:24.966Z pid=1369617 tid=t329 class=EmailJob jid=bcf503cde7f6660f7db695ab bid=pza8h2KmvtHT3g elapsed=5.014 INFO: done
EmailJob created 3
EmailJob created 2
(called from /home/pcs200/.rvm/gems/ruby-3.0.0/gems/sidekiq-batch-0.1.6/lib/sidekiq/batch.rb:182:in `block in process_successful_job'}
2022-03-07T07:59:24.967Z pid=1369617 tid=t365 class=EmailJob jid=ccd2c05da5f08a1302665f0d bid=pza8h2KmvtHT3g elapsed=5.012 INFO: done
EmailJob created 1
Pipelining commands on a Redis instance is deprecated and will be removed in Redis 5.0.0.

(called from /home/pcs200/.rvm/gems/ruby-3.0.0/gems/sidekiq-batch-0.1.6/lib/sidekiq/batch.rb:182:in `block in process_successful_job'}
2022-03-07T07:59:24.968Z pid=1369617 tid=t36h class=EmailJob jid=47a12e78e2ad2c9cb779125e bid=pza8h2KmvtHT3g elapsed=5.013 INFO: done
EmailJob created 4
(called from /home/pcs200/.rvm/gems/ruby-3.0.0/gems/sidekiq-batch-0.1.6/lib/sidekiq/batch.rb:182:in `block in process_successful_job'}

(called from /home/pcs200/.rvm/gems/ruby-3.0.0/gems/sidekiq-batch-0.1.6/lib/sidekiq/batch.rb:182:in `block in process_successful_job'}
Pipelining commands on a Redis instance is deprecated and will be removed in Redis 5.0.0.

(called from /home/pcs200/.rvm/gems/ruby-3.0.0/gems/sidekiq-batch-0.1.6/lib/sidekiq/batch.rb:207:in `block in enqueue_callbacks'}
(called from /home/pcs200/.rvm/gems/ruby-3.0.0/gems/sidekiq-batch-0.1.6/lib/sidekiq/batch/callback.rb:64:in `block in complete'}
(called from /home/pcs200/.rvm/gems/ruby-3.0.0/gems/sidekiq-batch-0.1.6/lib/sidekiq/batch.rb:207:in `block in enqueue_callbacks'}
(called from /home/pcs200/.rvm/gems/ruby-3.0.0/gems/sidekiq-batch-0.1.6/lib/sidekiq/batch.rb:141:in `block in persist_bid_attr'}
(called from /home/pcs200/.rvm/gems/ruby-3.0.0/gems/sidekiq-batch-0.1.6/lib/sidekiq/batch.rb:45:in `block in on'}
(called from /home/pcs200/.rvm/gems/ruby-3.0.0/gems/sidekiq-batch-0.1.6/lib/sidekiq/batch.rb:65:in `block in jobs'}
(called from /home/pcs200/.rvm/gems/ruby-3.0.0/gems/sidekiq-batch-0.1.6/lib/sidekiq/batch.rb:88:in `block in jobs'}
2022-03-07T07:59:24.975Z pid=1369617 tid=t385 class=EmailJob jid=867f37b1a06d186a0593c7a5 bid=pza8h2KmvtHT3g elapsed=5.019 INFO: done
2022-03-07T07:59:24.970Z pid=1369617 tid=t36p class=EmailJob jid=d57aa2506a62d65fcc32f582 bid=pza8h2KmvtHT3g elapsed=5.014 INFO: done
2022-03-07T07:59:24.976Z pid=1369617 tid=t399 class=Sidekiq::Batch::Callback::Worker jid=3193561a32cecdcc558d4f10 bid=zmJhHWXTfbUAmA INFO: start
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#<Sidekiq::Batch::Status:0x00007fdde402abb0>
{"custome_id"=>101}
	custome job completed




We can see EmailJob is creating 1 completed after EmailJob Created 4


	
