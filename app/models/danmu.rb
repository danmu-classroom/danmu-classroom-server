class Danmu < ApplicationRecord
  belongs_to :room
  belongs_to :sender
end
