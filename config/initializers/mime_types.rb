# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone
Mime::Type.register "application/pdf", :pdf

Mime::Type.register "application/vnd.ms-excel", :xls

format.pdf do
  kit = PDFKit.new(render_to_string(:template => "publications/show.html",
                                    :layout => "views/layouts/application.html.erb"))
  # stylesheets in tmp because I'm using compass
  kit.stylesheets << Rails.root.join('public', 'stylesheets', 'application.css').to_s
  render :text => kit.to_pdf
end
