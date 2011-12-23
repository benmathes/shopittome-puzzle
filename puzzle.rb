=begin
    I decied to write this with a class mostly to play
    with Ruby's class syntax/behavior. A quick script could easily have done the
    job well, especially since the puzzle is so specialized. Some of my comments 
    may be overly verbose and explain things obvious to someone who has spent a 
    lot of time in Ruby; As I am not an expert in Ruby, what is obvious and what
     needs documentation to a ruby export is as of yet unknown to me.
=end

# HTML parser gems
require 'open-uri'
require 'nokogiri'


# this class will parse a blog and print the posts of
# the shopittome blog
class ShopItToMeBlogParser


    # the content might change, though, so it's an instance-level variable.
    @blogURL
    @doc
    @posts = []


    # initializer method that sets the URL of the blog we'll parse
    def initialize(blogURL)
        @blogURL = blogURL
    end


    # fetches the latest source from the blog URL and parses it
    def getHTML
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
        allPostsElements = blogContent.element_children()
        thisPost = nil
        allPostsElements.each do |element|
            puts element.node_type()
=begin
            if thisElement.node_type() == ''
                @posts.push({
                    "title"  => title.content,
                    "images" => []
                })
            end

            if image
                push image info on to this blog post  images
            end

            images = 
            @posts.title
=end
        end
    end


    # after posts are parsed and put into @posts, this prints them
    def printPosts()
        # go throuch each post...
        i = 0
        until i >= @posts.length 
            post = @post[i]

            # ... print the title...
            puts "#{i}. #{post["title"]}"

            # ... and all the images therein
            post["images"].each do |image|
                puts "  - #{image["src"]}"
            end
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
