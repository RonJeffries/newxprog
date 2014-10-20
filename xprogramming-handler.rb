require 'sinatra/base'
require 'kramdown'
require "yaml"

set :static, false

class XprogrammingHandler < Sinatra::Base

  set :markdown, :parse_block_html => false
  set :markdown, :smartypants => true

  Article = Struct.new(:icon, :category, :title, :precis, :link) 

  def getPicture(category)
    case category.downcase
    when "kate oneal"
      "kate.png"
    when "articles"
      "viewtoday.png"
    when "beyond agile"
      "katetrans.png"
    else
      "foo.png"
    end
  end

  get '/' do
    # TODO SORT THEM
    # TODO: WHAT IF THERE IS NO FILE
    # TODO: WHAT IF THE MARKDOWN FILE DOESN'T END IN .md
    # TODO: WHAT IF THERE'S NO YAML IN THE FILE

    all_paths = Dir.glob(settings.public_folder + '/articles/*')
    articles = all_paths.collect do | path | 
      link = "articles/" + File.basename(path)
      markdown_file = Dir.glob(path + "/*.md")[0]
      headers = YAML.load(File.read(markdown_file))
      precis = headers["precis"] || "Read this article without having any clue what it is about."
      category = headers["category"] || "Articles"
      picture_name = getPicture(category)
      Article.new(picture_name, category, headers["title"], markdown(precis),link )
    end
    (0..5).each do |i|
      articles << Article.new("kate.png", "Kate Oneal", "Dummy Title #{i}", 
        "<p>Dummy Precis which has now been made about as long as the other</p>")
    end
    @favorites = articles[0..2]
    @the_rest = articles[3..-1]
    erb :home
  end

  get '/articles/*' do |slug|
      markdown_file = Dir.glob(settings.public_folder + "/articles/#{slug}/*.md")[0]
      file_contents = File.read(markdown_file)
      article_body = file_contents.split(/^---/)[-1]
      markdown_img_matcher = /\!\[(?<alt>.*)\]\((?<pic>.+)\)/
      replacement = "![\\k<alt>](/articles/#{slug}/\\k<pic>)"
      article_body.gsub!(markdown_img_matcher, replacement)
      @article_content = markdown article_body
      erb :article
  end
end
