# config/initializers/pdfkit.rb

PDFKit.configure do |config|     
# bin was vendor
# http://blog.mattgornick.com/using-pdfkit-on-heroku
# config.wkhtmltopdf = Rails.root.join('vendor', 'wkhtmltopdf-amd64').to_s if RAILS_ENV == 'production'
# https://gist.github.com/768696#file_assets.rb
config.root_url = "file://#(Rails.root.join('public'))/"
end

