require 'test_helper'
require 'rake'

class RoomsCloseTaskTest < ActiveSupport::TestCase
  setup do
    Rails.application.load_tasks if Rake::Task.tasks.empty?
    Rake::Task['rooms:close'].reenable
  end

  test 'rooms:close takes rooms older than 3 hours offline' do
    old_room = Room.create!(created_at: 4.hours.ago)
    new_room = Room.create!

    assert_output(/Rooms closed/) { Rake::Task['rooms:close'].invoke }

    assert_not old_room.reload.online
    assert new_room.reload.online
  end
end
