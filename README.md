[![Gitter][1]][2]

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

Copy the contains of config/env.sh.example to a new file called env.sh. Change the values if necessary. It's used to provide environmental variables.

    bundle install
    env SYSOPIA=config/env.sh bundle exec rake db:create:all
    env SYSOPIA=config/env.sh bundle exec rake db:migrate
    env SYSOPIA=config/env.sh bundle exec rake db:seed
    env SYSOPIA=config/env.sh bundle exec rackup

    For Development(to automatically restart the server after making a change)
    env SYSOPIA=config/env.sh rerun rackup

Sysopia now should run in development mode and show graphs with fake data at
http://localhost:9292

For debugging you can run

    SYSOPIA=config/env.sh bundle exec rake console

Release of a New Version
------------------------

When code's version is ready to be upgraded

* Change version number at [lib/sysopia/version.rb][3]

* Add record to [CHANGELOG.md file][4]

* Run rake release

    SYSOPIA=config/env.sh bundle exec rake release

* Go to production branch and merge it with master. This step will also
  generate new Docker image at [Docker Hub][5]

[1]: https://badges.gitter.im/Join%20Chat.svg
[2]: https://gitter.im/EOL/sysopia?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge
[3]: https://raw.githubusercontent.com/EOL/sysopia/master/lib/sysopia/version.rb
[4]: https://raw.githubusercontent.com/EOL/sysopia/master/CHANGELOG.md
[5]: https://registry.hub.docker.com/u/encoflife/sysopia/
