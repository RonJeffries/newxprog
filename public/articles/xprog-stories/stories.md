title: "XProg - Stories"
category: Articles
---

# XProgramming Stories

Date last edited: 20140926

Stories are in no particular order for now.

## General Remarks

## Story Repository

### Site has home page

The home page of the site provides access to all the articles on the site, not necessarily directly. If will probably show things in chronological order but with exceptions such as "classics" that are called out, or Kate articles or the like.

### Site can display article pages

The point of the site is to display articles. A simple, clean format is desired.

### Site is temporarily deployed on Heroku

For experience, possibly raising user consciousness, and perhaps other reasons, we want the site to have a Heroku implementation during development. The address may or may not be made more or less "public".

### Articles written in Markdown

New articles will be written in Markdown. It is desired to keep this as clean and standard as possible but some kinds of indications may be necessary and some may be desirable. 

### Simple HTML and CSS

It is desired to have pages use simple HTML and CSS. It may be necessary to do special things to get special effects. This is low priority compared to getting a clean site into operation.

### Articles may contain pictures

For ease in writing, the `![](foo.jpg)` format is desirable. For ease in packaging articles, the pictures should be in the same folder as the article. No special folder or other identification should be required in the markdown.

### Article slugs

Articles will be identified by "slugs", strings of text. The new site must support old existing XProgramming slugs. 

### Slugs as folders

Initial design at least is that articles and associated files will each ben in a unique folder. The folder name will be the article slug. The folders will be in public/articles/. 

### UX Clean and clear

### UX uses Ron's own drawings for graphics

### Article metadata (YAML)

Articles will have title, content, date, precis and possibly other metadata. Metadata can be used in search, in display of lists, etc., TBD.

Initial metadata will be in YAML embedded in the article file.

### Article icons

An article will have an "icon", a small image, used to identify it in lists. The icon may or may not appear on the article page as well.

### Icon is a function of "Category"

### Icon can be unique to the article

System should provide for an article to include a unique icon. If one exists it will override the category icon wherever the icon appears.

### Home page formatting

Home page wants to show article icon, category, title, and precis. Article precis are short, tweet-sized. Home page layout should take this into account.

### Article layout, pictures beside text.

The existing site has pictures in line with text. The new design *could* allow pictures to rise up beside the paragraph they follow (but no higher). This might look attractive. We need not offer that capability. No major inconvenience to the author, and no significant complexity in the implementation, should be required by such facility were it to be done.