# config/initializers/pdfkit.rb

PDFKit.configure do |config|     
 config.wkhtmltopdf = Rails.root.join('vendor', 'wkhtmltopdf-amd64').to_s if RAILS_ENV == 'production'
  config.default_options = {
    :page_size => 'A4',
    :print_media_type => true
    }
  config.root_url = "file://#(Rails.root.join('public'))/" if RAILS_ENV == 'production'
end

