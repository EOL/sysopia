Sysopia
=======
A dashboard to visualize a small/medium system status

Development
-----------
Install mysql and mysql development package.

    #for debian, ubuntu, mint etc.
    apt-get update
    apt-get install mysql-server libmysqlclient-dev

Prepare gems, databases, seed data. If mysql is located at your
localhost, connected to 127.0.0.1 and has no password for root you can use
[config/env.sh][1] file to provide environmental variables. Copy env.sh
to your own file and change values if necessary.

    bundle install
    SYSOPIA=config/env.sh bundle exec rake db:create:all
    SYSOPIA=config/env.sh bundle exec rake db:migrate
    SYSOPIA=config/env.sh bundle exec rake seed
    SYSOPIA=config/env.sh bundle exec rackup

Sysopia now should run in development mode and be accessible at
http://localhost:9292


[1]: https://raw.githubusercontent.com/EOL/sysopia/master/config/env.sh

