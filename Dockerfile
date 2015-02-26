FROM ruby:2.1-onbuild
CMD ["SYSOPIA=/usr/src/app/config/env.sh unicorn -c /usr/src/app/config/unicorn.rb"]

