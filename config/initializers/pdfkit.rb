# config/initializers/pdfkit.rb

PDFKit.configure do |config|     
# bin was vendor
# http://blog.mattgornick.com/using-pdfkit-on-heroku
config.wkhtmltopdf = Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s if RAILS_ENV == 'production'

end

