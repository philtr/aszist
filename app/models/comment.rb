class Comment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
end
