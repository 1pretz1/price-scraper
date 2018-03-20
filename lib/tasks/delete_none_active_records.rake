desc 'Delete records that are inactive that are older than 7 days'
task :delete_none_active_records => :environment do
  Product.delete_all("deleted_at < '#{7.days.ago}'")
  # or Model.delete_all('created_at < ?', 60.days.ago) if you don't need callbacks
end
