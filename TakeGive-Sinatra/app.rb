require 'sinatra'
require 'mongoid'

configure do
  Mongoid.configure do |config|
    config.sessions = { default: { hosts: ["ds045087.mongolab.com:45087"], database: "takegive", username: "takegive", password: "1VHhYEpjX48wXjBGtRN5faPA6CvcNGUSSPe.n_jJZN8-" } }
  end
end

class Item
  include Mongoid::Document
  store_in collection: "item"
end

get '/' do;"hi";end

get '/api/find/bybox' do
  content_type 'application/json'
  f, s = params[:f].split(",").map{ |l| l.to_f }, params[:s].split(",").map{ |l| l.to_f }
  Item.where({ 'location' => { "$geoWithin" => { "$box" => [ f , s ] }}}).to_json
end

get '/api/find/byquery' do
  content_type 'application/json'
  Item.where({ name: /#{params[:q]}/i }).to_json
end
