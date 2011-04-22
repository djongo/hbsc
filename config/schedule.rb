# Add to cron with following command:
# whenever --update-crontab PUMA
#
# check crontab with "crontab -l"

# send reminders

set :environment, :development
set :output, {:error => 'log/error.log', :standard => 'log/cron.log' }

every 1.day, :at => '7:00 am' do
  rake "remind"
end
