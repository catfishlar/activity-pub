# The Code Base
Reference: 
  * Github : https://github.com/mastodon/mastodon
  * Rspec: Great way to understand the code is Testing.  The `mastodon/spec` directory.  
  * Rspec Github: https://github.com/rspec/rspec-rails
  * Rail Guides: https://guides.rubyonrails.org/
 
Other People editing Mastodon Code:
  * [Increase toot length, example of changing code on running site](https://www.draklyckan.se/2021/11/how-to-increase-the-character-limit-for-toots-in-mastodon/)

## Approaches to the code

Ruby culture is insane with indirection and Ruby on Rails is full implicit behaviour.   RoR is the source of the 
call for convention over configuration, so you really need to understand the conventions.   Good thing is 
a little bit of Ruby on Rails review goes a long way.   

Another aspect of the Ruby world is that being dynamic and built on convention, the Ruby world became the center of 
test first development.  Ruby programs have tests, partly because if they didn't you'd get all kinds of runtime errors 
based on code paths never having been excersized.  Turns out Mastodon has a ton of Rspec Tests.  

Intellij with Ruby and Rails plugins, and the spec directory will go a long way to teasing out what does what. 

The front end is React.js, but since I really mostly interested in state and processing, I can pretty much ignore 
the UI.  For example.  I wanted to know where to start with post of a Toot.  Well I look at the UI and there is a 
default text of "Whats on your mind?", searching the code base for that, I get.  

    "compose_form.placeholder": "What's on your mind?",

From there I knew that javascript in rails goes in `app/javascript` seeing `mastodon` directory.. `actions` directory
and then `compose.js`.  And hunting about you can see that this that dialog. 

from there you see where it gets sent.. that will be the Ruby on Rails side.  At that point, its coming in as  model and 
who cares what the UI did. 

