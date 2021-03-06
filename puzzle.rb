=begin
    I decied to write this with a class mostly to play
    with Ruby's class syntax/behavior. A quick script could easily have done the
    job well, especially since the puzzle is so specialized. Some of my comments 
    may be overly verbose and explain things obvious to someone who has spent a 
    lot of time in Ruby; As I am not an expert in Ruby, what is obvious and what
    needs documentation to a ruby export is as of yet unknown to me.
=end

# HTML parser gems
require 'rubygems'
require 'open-uri'
require 'nokogiri'


# this class will parse a blog and print the posts of
# the shopittome blog
class ShopItToMeBlogParser
    @blogURL
    @doc
    @posts


    # initializer method that sets the URL of the blog we'll parse
    def initialize(blogURL)
        @blogURL = blogURL
        @posts = Array.new()
    end


    # fetches the latest source from the blog URL and parses it
    def getHTML
        puts "fetching the blog at #{ @blogURL }..."
        @doc = Nokogiri::HTML(open(@blogURL))
    end


    # parses the fetched @doc
    def parsePosts

        # this relies on the DOM structure of blog.shopittome.com:
        #     <h2 class="title">...</h2>
        #     <p class="post-body">...</p>
        #     <h2 class="different-title">...</h2>
        #     <p class="different-post-body">...</p>
        # this means we have to iterate over everything that is at that flat level.
        blogContent = @doc.css('#content_inner')
        allPostsElements = blogContent.children()
        thisPost = nil
        allPostsElements.each do |element|

            # post titles are <h2>'s...
            if element.node_name() == 'h2'
                thisPost = {
                    # ... with a link inside            
                    "title"  => element.css('a').inner_text(),
                    "images" => Array.new()
                }
                @posts.push(thisPost)
            end

            # we need to fetch all the images for "this" blog post,
            # which is unfortunately separated horizontally in a structure
            # better suited by vertical separation, a (DOM) tree.
            # That structure means checking every node we find recursively for images
            # until we get to the next <h2>, which separates blog posts.
            images = element.css('img').each do |image|
                thisPost["images"].push(image)
            end

        end
    end


    # after posts are parsed and put into @posts, this prints them
    def printPosts()
        # go throuch each post...
        i = 0
        until i >= @posts.length 
            post = @posts[i]

            # ... print the title...
            puts "#{i+1}. #{post["title"]}"

            # ... and all the images therein
            post["images"].each do |image|
                puts "    - #{image["src"]}"
            end

            i = i + 1
        end
    end


    # the "do everything" function, which is a convenience
    def parseBlogAndPrint()
        self.getHTML()
        self.parsePosts()
        self.printPosts()
    end

end




######### actual exection ######### 
if __FILE__ == $0
    blogParser = ShopItToMeBlogParser.new('http://blog.shopittome.com')
    blogParser.parseBlogAndPrint()
end
