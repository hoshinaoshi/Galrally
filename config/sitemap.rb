# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://galrally.info/"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  add '/blogs', :changefreq => 'daily', :priority => 0.99

  Blog.find_each do |blog|
    add blog_path(blog), :lastmod => blog.updated_at, :changefreq => 'daily'
  end

end
