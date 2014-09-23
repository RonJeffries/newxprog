---
title: XProg - Progress
category: Articles
precis: Progress report on the ongoing XProgramming rewrite.
---

#  XProg - Progress etc. 

Tozier and I worked on the new thing yesterday. I had written a little article with a picture in it, to drive our plan of keeping each article in a folder named by its "slug", with pictures and metadata in that same folder. 

This would allow the \!\[\]\(\) notation for pictures to "just work".  Well, it didn't just work. After long internetting, we found that Sinatra wants "assets" like that to be in a folder named "public", and it seems that templates are evaluated as if they are in that folder, even though they are not. 

We found thst you can change that folder. That turns out to mean that you can give it another name, not really say "assets are now in 'this/that/'.  We found that you can't navigate out of that folder by any combination of "../" magic. We found that this is probably a function of "rackup", not of Sinatra.

Finally, Cory Foy, tweeted a reply that I was finally able to understand, that involves using send_file upon seeing the get for the picture. Understanding required me to learn, or relearn, a little about Ruby, about Sinatra, and about how the Internet works. Also maybe some quantum physics, I'm not sure. Anyway thanks to Cory and all the folks who tweeted info and help in response to my crying in the wilderness.

The result is that in three three hour sessions, we have my computer set up with the right stuff, and a rudimentary Sinatra thing running that looks a lot like what we're trying to do. We have not, however, started TDDing, but with no methods and each get being about two lines, there's not much to TDD yet. Next week for that, too, I think.