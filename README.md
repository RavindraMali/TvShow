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



