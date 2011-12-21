# I decied to write this with a class mostly to play
# with Ruby's class syntax/behavior. A quick script could easily have done the
# job as well. Some of my comments may be overly verbose and explain
# things obvious to someone who has spent a lot of time in Ruby;
# As I am not an expert in Ruby, what is obvious and what needs documentation
# to an export is as of yet unknown to me.

# HTML parsers. required for proper installation
# sudo gem install nokogiri
# sudo gem install open-uri
require 'nokogiri'
require 'open-uri'

class BlogGetter

    # the shopittome blog URL doesn't change from instance-to-isntance
    @@blogAddress = 'blog.shopittome.com'

    # the content might change, though, so it's an instance-level variable.
    @doc

    # whether to use wget or 'curl -0' depends on the OS
    @os = ''

    # start up this instance by setting the OS we're on
    def initialize(os)
        @os = os.downcase
    end

    # fetches the latest source from @@blogAddress
    # and parses it
    def getLatestPost
        @doc = Nokogiri::HTML(open(@@blogAddress))
        
    end
    
    def sayHi
        puts "why, hello there!"
    end
end



######### actual exection ######### 
if __FILE__ == $0
    blogGeter = BlogGetter.new
    blogGeter.getLatestPost
end
