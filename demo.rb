require 'sinatra/base'
require 'kramdown'
#require "rdiscount"

set :static, false

class SinatraDemo < Sinatra::Base

  set :markdown, :parse_block_html => true
  set :markdown, :smartypants => true

Article = Struct.new(:icon, :header, :title, :content)

a1 = Article.new("katetrans.png", "Beyond Agile", \
                "This is interesting", \
                "This is a particularly interesting article which all should consider and enjoy.")
a2 = Article.new("kate.png", "Annals of Kate Oneal", "Kate makes us laugh", \
                "That is a fascinating compendium of topical subjects arranged in a amusing fashion.")
a3 = Article.new("kate.png", "Classics", "Consider this, vagrants!", \
                "The other is something well worth consideration by the thoughtful reader as well as the itinerant browser.")

  get '/' do
    actual_article = File.read(settings.public_folder + "/articles/xprog-layout/xprog-layout.md")
    @article = markdown actual_article

    #markdown = RDiscount.new(actual_article)
    #@article = markdown.to_html
    @fave = [a1, a2, a3]
    # this means that the erb has to know an array is coming.
    # could instead build up a longer HTML but the erb has a header in it
    
    erb :frontpage
    # what's returned here is what's displayed
  end

  get '/image/:img' do
    send_file File.join('public/articles/xprog-layout/', params[:img]), :type => 'image/jpeg', :disposition => 'inline'
  end
end
