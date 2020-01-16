#https://jekyllrb.com/docs/plugins/generators/
module Jekyll
  class EventbritePageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'eventbrite'
        dir = site.config['category_dir'] || 'categories'
	site.posts.each do |post|
		if post.url.start_with?("/events/")
			site.pages << CategoryPage.new(site, site.source, dir, post.url.delete_prefix("/events/"),post.content)
	  end
        end
      end
    end
  end

  # A Page subclass used in the `CategoryPageGenerator`
  class CategoryPage < Page
    def initialize(site, base, dir, postid,postcontent)
      @site = site
      @base = base
      @dir  = dir
      @name = postid

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'eventbrite.html')
      self.data['postcontent'] = postcontent
      self.data['category'] = 'eventbrite'

      category_title_prefix = site.config['category_title_prefix'] || 'Category: '
      self.data['title'] = "#{category_title_prefix}eventbrite"
    end
  end
end
