class Match < ActiveRecord::Base
    belongs_to :page
    belongs_to :keyword
end