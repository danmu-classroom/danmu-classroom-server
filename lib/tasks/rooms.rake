namespace :rooms do
  desc 'Close timeout rooms.'
  task close: :environment do
    puts 'Closing Rooms where created over 3 hours.'
    rooms = Room.where(online: true).where('created_at < :time', time: 3.hours.ago)
    rooms.update_all(online: false)
    puts "Room: #{rooms.ids} closed."
  end
end
