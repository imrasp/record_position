class Part < ApplicationRecord
  belongs_to :aircraft
  belongs_to :status
end
