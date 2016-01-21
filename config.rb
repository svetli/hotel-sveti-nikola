###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page '/sitemap.xml', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Automatic image dimensions on image_tag helper
#activate :automatic_image_sizes

# Directory Indexes
activate :directory_indexes

# Timezone
Time.zone = 'Sofia'

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
#helpers do
#  get_menu_labels(labels)
#    labels.map do |label|
#      [label, I18n.t("corporate.#{label}.title")]
#    end.to_h
#  end
#end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
  
  # Minify HTML
  #activate :minify_html
  
  # Use relative URLs
  activate :relative_assets
  
  # Add asset fingerprinting to avoid cache issues
  activate :asset_hash
end

activate :i18n, mount_at_root: :bg
