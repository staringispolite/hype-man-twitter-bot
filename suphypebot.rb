#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'

if ENV['ENV'] == 'DEVELOPMENT'
  require 'dotenv'
  Dotenv.load
end

#
# this is the script for the twitter bot suphypebot
# generated on 2015-10-07 13:10:26 -0700
#
#
consumer_key = ENV['CONSUMER_KEY']
consumer_secret = ENV['CONSUMER_SECRET']
secret = ENV['SECRET']
token = ENV['TOKEN']
db_uri = ENV['CLEARDB_DATABASE_URL']

# remove this to get less output when running
verbose

# here's a list of users to ignore
blacklist "abc", "def"

# here's a list of things to exclude from searches
exclude "hi", "spammer", "junk"
exclude "http://", "https://"

# List of HYPE.AF phrases it can reply with
hype_responses = "HANDS UP!", "IT'S YA BOI!", "Chyeah!",
  "EVERYBODY IN THE TWITTER PUT YOUR HANDS UP!",
  "ALL THE LADIES IN THE TWITTER PUT YOUR HANDS UP!",
  "ALL THE FELLAS IN THE TWITTER PUT YOUR HANDS UP!",
  "Yeeaaaaayuh!", "Let's go!", "Y'all ain't ready for this!",
  "Too much!", "Put em up! Put em up!", "Yeah, yeah, yeah, yeah!",
  "When I say fav! You say tweet! FAV!"

streaming do
  #search "#twitterhypeman" do |tweet|
  # reply "#{tweet_user(tweet)} CHYEAH!", tweet
  #end
  replies do |tweet|
    puts "replying to tweet ", tweet.text
    usernames = ""
    tweet.text.scan(/@\w+/).each { |user|
      if user != "@suphypebot"
        usernames += user + " "
      end
    }
    hype_response = hype_responses.sample
    reply "#{tweet_user(tweet)} %s %s" % [usernames.strip, hype_response], tweet
  end
  # Don't go crazy with the infinite looping
end
