#!/bin/bash
# uses migrations to construct database then seeds database with test data
rake db:migrate
rake db:schema:load
rake db:seed RAILS_ENV=development
