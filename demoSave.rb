require 'sinatra/base'
require 'kramdown'

set :static, false
class SinatraDemo < Sinatra::Base

  get '/' do
    @actual_article = File.read(File.dirname(__FILE__) + "/articles/xprog-implementing-anew/XProgAnew.md")
    @article = markdown @actual_article #"# Cool Article\n\nThis is a long paragraph.\n![](slug/updown.png){:.float-right width=\"200\"}\n\nSo is this."
    @fave = markdown "Read this you darling SOB"
    
    erb :frontpage
    # what's returned here is what's displayed
  end

  get '/image/:img' do
    send_file File.join('articles/xprog-implementing-anew/', params[:img]), :type => 'image/jpeg', :disposition => 'inline'
  end
end
