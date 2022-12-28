# Ruby Thursday

Going through the first tuturial

## Ruby Thurday 1 

https://www.youtube.com/watch?v=Bw9jfBUQTkc

### Install RVM

[Install RVM step by step](https://nrogap.medium.com/install-rvm-in-macos-step-by-step-d3b3c236953b)
    
        HilarysMacPro:rails lmurdock$ brew update
        HilarysMacPro:rails lmurdock$ brew install gnupg
        HilarysMacPro:rails lmurdock$ gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
        gpg: directory '/Users/lmurdock/.gnupg' created
        gpg: keybox '/Users/lmurdock/.gnupg/pubring.kbx' created
        gpg: keyserver receive failed: Server indicated a failure
        HilarysMacPro:rails lmurdock$ gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
        gpg: key 105BD0E739499BDB: 1 duplicate signature removed
        gpg: /Users/lmurdock/.gnupg/trustdb.gpg: trustdb created
        gpg: key 105BD0E739499BDB: public key "Piotr Kuczynski <piotr.kuczynski@gmail.com>" imported
        gpg: key 3804BB82D39DC0E3: public key "Michal Papis (RVM signing) <mpapis@gmail.com>" imported
        gpg: Total number processed: 2
        gpg:               imported: 2
        HilarysMacPro:rails lmurdock$ \curl -sSL https://get.rvm.io | bash
        Downloading https://github.com/rvm/rvm/archive/master.tar.gz
        Installing RVM to /Users/lmurdock/.rvm/
            Adding rvm PATH line to /Users/lmurdock/.profile /Users/lmurdock/.mkshrc /Users/lmurdock/.bashrc /Users/lmurdock/.zshrc.
            Adding rvm loading line to /Users/lmurdock/.profile /Users/lmurdock/.bash_profile /Users/lmurdock/.zlogin.
        Installation of RVM in /Users/lmurdock/.rvm/ is almost complete:

        To start using RVM you need to run `source /Users/lmurdock/.rvm/scripts/rvm`
        in all your open shell windows, in rare cases you need to reopen all shell windows.

        Thanks for installing RVM 🙏
        Please consider donating to our open collective to help us maintain RVM.

        👉  Donate: https://opencollective.com/rvm/donate


        HilarysMacPro:rails lmurdock$ rvm list
        -bash: rvm: command not found

either open a new shell or do this

        HilarysMacPro:rails lmurdock$ source /Users/lmurdock/.rvm/scripts/rvm
        HilarysMacPro:rails lmurdock$ rvm list

        # No rvm rubies installed yet. Try 'rvm help install'.
        
        HilarysMacPro:rails lmurdock$ 

### Install RUBY

* Ruby Version in Mastodon - https://github.com/mastodon/mastodon/blob/main/.ruby-version


        ruby -v
        rvm list known

        HilarysMacPro:rails lmurdock$ rvm install ruby 3.0
        Searching for binary rubies, this might take some time.
        No binary rubies available for: osx/11.6/x86_64/ruby-3.0.5.
        Continuing with compilation. Please read 'rvm help mount' to get more information on binary rubies.
        Checking requirements for osx.
        Installing requirements for osx.
        Updating system..........
        Installing required packages: autoconf, automake, coreutils, libyaml, zlib........
        Certificates bundle '/usr/local/etc/openssl@1.1/cert.pem' is already up to date.
        Requirements installation successful.
        Installing Ruby from source to: /Users/lmurdock/.rvm/rubies/ruby-3.0.5, this may take a while depending on your cpu(s)...
        ruby-3.0.5 - #downloading ruby-3.0.5, this may take a while depending on your connection...
          % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                         Dload  Upload   Total   Spent    Left  Speed
        100 20.3M  100 20.3M    0     0  58.5M      0 --:--:-- --:--:-- --:--:-- 58.4M
        ruby-3.0.5 - #extracting ruby-3.0.5 to /Users/lmurdock/.rvm/src/ruby-3.0.5.....
        ruby-3.0.5 - #autogen.sh.
        ruby-3.0.5 - #configuring................................................................
        ruby-3.0.5 - #post-configuration.
        ruby-3.0.5 - #compiling......................................................................
        ruby-3.0.5 - #installing...............
        ruby-3.0.5 - #making binaries executable...
        Installed rubygems 3.2.33 is newer than 3.0.9 provided with installed ruby, skipping installation, use --force to force installation.
        ruby-3.0.5 - #gemset created /Users/lmurdock/.rvm/gems/ruby-3.0.5@global
        ruby-3.0.5 - #importing gemset /Users/lmurdock/.rvm/gemsets/global.gems.........................................-
        ruby-3.0.5 - #generating global wrappers........
        ruby-3.0.5 - #gemset created /Users/lmurdock/.rvm/gems/ruby-3.0.5
        ruby-3.0.5 - #importing gemsetfile /Users/lmurdock/.rvm/gemsets/default.gems evaluated to empty gem list
        ruby-3.0.5 - #generating default wrappers........
        ruby-3.0.5 - #adjusting #shebangs for (gem irb erb ri rdoc testrb rake).
        Install of ruby-3.0.5 - #complete 
        Ruby was built without documentation, to build it run: rvm docs generate-ri
        HilarysMacPro:rails lmurdock$  

### Install Rails

        
        HilarysMacPro:rails lmurdock$ ruby -v
        ruby 3.0.5p211 (2022-11-24 revision ba5cf0f7c5) [x86_64-darwin20]
        HilarysMacPro:rails lmurdock$ ls -la
        total 0
        drwxr-xr-x  2 lmurdock  staff   64 Dec 27 01:28 .
        drwxr-xr-x  4 lmurdock  staff  128 Dec 27 01:28 ..
        HilarysMacPro:rails lmurdock$ gem install rails
        Fetching thor-1.2.1.gem
        Fetching method_source-1.0.0.gem
        Fetching i18n-1.12.0.gem
        Fetching zeitwerk-2.6.6.gem
        Fetching concurrent-ruby-1.1.10.gem
        Fetching tzinfo-2.0.5.gem
        Fetching activesupport-7.0.4.gem
        Fetching nokogiri-1.13.10-x86_64-darwin.gem
        Fetching crass-1.0.6.gem
        Fetching loofah-2.19.1.gem
        Fetching rails-html-sanitizer-1.4.4.gem
        Fetching rails-dom-testing-2.0.3.gem
        Fetching rack-2.2.5.gem
        Fetching rack-test-2.0.2.gem
        Fetching erubi-1.12.0.gem
        Fetching builder-3.2.4.gem
        Fetching actionview-7.0.4.gem
        Fetching actionpack-7.0.4.gem
        Fetching railties-7.0.4.gem
        Fetching mini_mime-1.1.2.gem
        Fetching marcel-1.0.2.gem
        Fetching activemodel-7.0.4.gem
        Fetching activerecord-7.0.4.gem
        Fetching globalid-1.0.0.gem
        Fetching activejob-7.0.4.gem
        Fetching activestorage-7.0.4.gem
        Fetching actiontext-7.0.4.gem
        Fetching mail-2.8.0.gem
        Fetching actionmailer-7.0.4.gem
        Fetching actionmailbox-7.0.4.gem
        Fetching websocket-extensions-0.1.5.gem
        Fetching rails-7.0.4.gem
        Fetching websocket-driver-0.7.5.gem
        Fetching nio4r-2.5.8.gem
        Fetching actioncable-7.0.4.gem


And then it installed those gems. 

        HilarysMacPro:rails lmurdock$ rails -v
        Rails 7.0.4

## Ruby Thurday 2  

https://www.youtube.com/watch?v=0n7qK75Acl8    

### Create New Site

So for this repo we are using rails-sites  as our starting point and the whole set of sites is in the repo.  

If something needs to be independent, then we can break that out, but this tutorial is part of this activity-pub repo

     cd ~/src/activity-pub/rails-sites

    rails new ruby_thursday -T

Minus T is to make no tests since we will be using RSpec, which Mastodon uses too. 

I captured the out put of createing ruby_thursday and it is [ruby_thursday.out](../../rails-sites/ruby_thursday.out) 


    cd ruby_thursday
    rm -rf .git

I leave  `.gitignore` and `.gitattributes` on the idea that they modify git in the directory in ways that matter to 
ruby on rails.  

## Ruby Thurday 3 

[Get Launching #3: Setting up Postgres and Rspec on Rails](https://www.youtube.com/watch?v=yOdLXYJHhV8&t=24s)

### Install Postgresql

ended up just installing postgres app from here. https://postgresapp.com/downloads.html  Quick up and down, now fuss 
no muss, good for these tutorials.  But not much of a Postgres experience. 

![where the configs are](images/postgresql-app.png)

To run the CLI tools using this.. Add this path to your .bashrc

    export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"

then of course its `psql` command.

### Configure Rails

#### GemFile

Gemfile has the code bundles you will use and the versions.  

One thing we change is `sqllite` to `pg`. Where `pg` is postgres. 

You can see versions of gems at https://rubygems.org

from this:

    group :development, :test do
      # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
      gem "debug", platforms: %i[ mri mingw x64_mingw ]
    end

to this:

    group :development, :test do
      gem 'better_errors'
      gem 'capybara-webkit'
      gem 'factory_girl_rails'
      gem 'ffaker'
      gem 'database_cleaner'
      gem 'letter_opener'
      gem 'rspec-rails'
      gem 'pry'
      gem 'pry-nav'
      gem 'pry-rails'
      gem 'simple_bdd'
      gem 'shoulda-matchers'
      gem 'spring'
      # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
      gem "debug", platforms: %i[ mri mingw x64_mingw ]
    end

#### Bundle

    bundle

failed with 

    To see why this extension failed to compile, please check the mkmf.log which can
    be found here:
    
    /Users/lmurdock/.rvm/gems/ruby-3.0.5/extensions/x86_64-darwin-20/3.0.0/pg-1.4.5/mkmf.log

I then went in there and there was a missing *.h file.  Well as it turns out its becasue of how I have my postgres set up
but going with [this stackoverflow](https://stackoverflow.com/questions/50272096/pg-1-0-0-fatal-error-libpq-fe-h-file-not-found)
I installed the library without installing all of postgres.  But this chanes what I have to do.. 

    brew install libpq

ended with the info. 

    ==> Summary
    🍺  /usr/local/Cellar/libpq/15.1: 2,367 files, 28.1MB
    ==> Running `brew cleanup libpq`...
    Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
    Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
    ==> Caveats
    ==> libpq
    libpq is keg-only, which means it was not symlinked into /usr/local,
    because conflicts with postgres formula.
    
    If you need to have libpq first in your PATH, run:
      echo 'export PATH="/usr/local/opt/libpq/bin:$PATH"' >> /Users/lmurdock/.bash_profile
    
    For compilers to find libpq you may need to set:
      export LDFLAGS="-L/usr/local/opt/libpq/lib"
      export CPPFLAGS="-I/usr/local/opt/libpq/include"

Which fits with that the stack overflow sez is the next step. 

     bundle config --local build.pg --with-opt-dir="/usr/local/opt/libpq"

oops make sure you are in the rails directory

    cd ~/src/activity-pub/rails-sites/ruby_thursday 
    bundle config --local build.pg --with-opt-dir="/usr/local/opt/libpq"
    bundle install

This time the error is with capybara-web-kit and it relates to missing qmake.. which is a part of `qt` ( a local
client software builder.  yep we used to buid apps before the web)

Fix seems to be to add qt

    brew install qt

then
    
    bundle install

then 

    Project ERROR: No QtWebKit installation found. QtWebKit is no longer included with Qt 5.6, so you may
    need to install it separately.

So the answer to this is to install 5.5.

    HilarysMacPro:ruby_thursday lmurdock$ brew uninstall qt
    Uninstalling /usr/local/Cellar/qt/6.4.1_1... (13,354 files, 578.3MB)
    HilarysMacPro:ruby_thursday lmurdock$ brew uninstall qt@5
    Error: No such keg: /usr/local/Cellar/qt@5
    HilarysMacPro:ruby_thursday lmurdock$ cd $( brew --prefix )/Homebrew/Library/Taps/homebrew/homebrew-core
    HilarysMacPro:homebrew-core lmurdock$ git checkout 9ba3d6ef8891e5c15dbdc9333f857b13711d4e97 Formula/qt@5.5.rb
    Updated 1 path from 741af0285f9
    HilarysMacPro:homebrew-core lmurdock$ brew install qt@5.5

from [this page](https://til.magmalabs.io/posts/308d996344-fixing-the-capybara-webkit-gem-installation-qtwebkit-is-no-longer-included-with-qt-56-error-on-m1-mac-with-big-sur)

Gah.. did you catch it.. 

    Error: No such keg: /usr/local/Cellar/qt@5

and messing with the file did not help much. 

So this seems definitive.. https://github.com/Homebrew/homebrew-core/issues/32467

>Is there anyway to be able to install Qt 5.5?
> 
>fxcoudert commented on Oct 9, 2018
>
>Not from Homebrew core, we do not provide this version anymore, as it failed to build on recent macOS versions.

hmm after looking around a bit, I looked at the Gemfile of mastodon and see that they use 

    gem capybara
not 

    gem capybara-webkit

So went with that.   This goes to show you.. the config issues of bitrotting Ruby and OLD tutorials.  

And finally we have everything.  Now is it going to work.  

####  Database Config

Change `config/database.yml` to use postgres. and change the names of the databases. 

        HilarysMacPro:config lmurdock$ git diff database.yml.org database.yml
        diff --git a/rails-sites/ruby_thursday/config/database.yml b/rails-sites/ruby_thursday/config/database.yml
        index fcba57f..7ad8985 100644
        --- a/rails-sites/ruby_thursday/config/database.yml
        +++ b/rails-sites/ruby_thursday/config/database.yml
        @@ -3,23 +3,25 @@
         #
         #   Ensure the SQLite 3 gem is defined in your Gemfile
         #   gem "sqlite3"
        +#   we are doing Postgress so
        +#   gem "pg"
         #
         default: &default
         -  adapter: sqlite3
         + adapter: postgresql
         pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
         timeout: 5000
 
         development:
           <<: *default
         -  database: db/development.sqlite3
         + database: db/ruby_thursday_development
 
         # Warning: The database defined as "test" will be erased and
         # re-generated from your development database when you run "rake".
         # Do not set this db to the same as development or production.
         test:
           <<: *default
         -  database: db/test.sqlite3
         + database: db/ruby_thursday_test
         
         production:
           <<: *default
         -  database: db/production.sqlite3
         + database: db/ruby_thursday_production

#### Rake DB:Create

Make sure to go back to the base of the rails app in my case

    cd /Users/lmurdock/src/activity-pub/rails-sites/ruby_thursday
    rake db:create

#### Install RSpec

    /Users/lmurdock/src/activity-pub/rails-sites/ruby_thursday
    HilarysMacPro:ruby_thursday lmurdock$ rails generate rspec:install
    DEPRECATION WARNING: The factory_girl gem is deprecated. Please upgrade to factory_bot. See https://github.com/thoughtbot/factory_bot/blob/v4.9.0/UPGRADE_FROM_FACTORY_GIRL.md for further instructions. (called from <main> at /Users/lmurdock/src/activity-pub/rails-sites/ruby_thursday/config/application.rb:19)
          create  .rspec
          create  spec
          create  spec/spec_helper.rb
          create  spec/rails_helper.rb


#### Add Gems to Rspec

          create  spec/rails_helper.rb
    HilarysMacPro:ruby_thursday lmurdock$ cd spec/
    HilarysMacPro:spec lmurdock$ vi rails_helper.rb

The world looks pretty different these days in there.. but we added these 3. 

    require 'spec_helper'
    require 'simple_bdd'
    require 'capybara/rspec'

And also add this after `config.use_transactional_fixtures = true`

      config.use_transactional_fixtures = true
    
      #from https://www.youtube.com/watch?v=yOdLXYJHhV8&t=24s
      config.include SimpleBdd, type: :feature
        # config.include Devise::TestHelpers, :type => :controller 
        config.before(:suite) do
          DatabaseCleaner.strategy = :truncation
          DatabaseCleaner.clean_with(:truncation)
        end
      
        config.before(:each) do 
          DatabaseCleaner.start
        end
    
        config.after(:each) do 
          DatabaseCleaner.clean
        end

