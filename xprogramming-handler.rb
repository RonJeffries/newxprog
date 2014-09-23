require 'sinatra/base'
require 'kramdown'
#require "rdiscount"

set :static, false

class XprogrammingHandler < Sinatra::Base

  set :markdown, :parse_block_html => true
  set :markdown, :smartypants => true


  Article = Struct.new(:icon, :header, :title, :content) # date?

  get '/' do

    @favorites = []
    erb :frontpage
  end

  get '/image/:img' do
    send_file File.join('public/articles/xprog-layout/', params[:img]), :type => 'image/jpeg', :disposition => 'inline'
  end
end
