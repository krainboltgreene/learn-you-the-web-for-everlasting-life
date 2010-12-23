#!/usr/bin/env ruby
# encoding: utf-8
author = "Kurtis Rainbolt-Greene"
created = ""

require 'sinatra'
require 'haml'
require 'sass'

set :port, 9000

configure :production do
    set :static, true
    set :cache_enabled, true

    set :haml, { attr_wrapper: '"', ugly: true, format: :html5 }
    set :sass, { style: :compressed }
end


get '/' do
    @view = {title: '', author: author, created: created}
    haml :index
end

get '/404' do
    @view = {title: 'Error 404: Aw snap :/', author: author}
    haml :fourohfour
end

get '/browser' do
    @view = {title: 'Browser Error: Whaaaaat!', author: author}
    haml :browser
end

get '/*.css?' do |sheet|
    content_type 'text/css', charset: 'utf-8'
    unless sheet == 'mobile'
        sass :standard
    else
        sass :mobile
    end
end

get '/*' do
    redirect '/404'
end
