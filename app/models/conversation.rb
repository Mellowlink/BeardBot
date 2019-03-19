class Conversation < ApplicationRecord
  belongs_to :user, optional: true
  has_many :messages
end
