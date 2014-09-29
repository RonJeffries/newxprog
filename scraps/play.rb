Article = Struct.new(:title, :content)

a1 = Article.new("Title", "This is the message")

puts a1.title
puts a1.content