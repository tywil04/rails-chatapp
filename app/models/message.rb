class Message < ApplicationRecord
  validates :body, presence: true
  validates :user, presence: true
  validates :room, presence: true

  belongs_to :user
  belongs_to :room

  after_create_commit { after_creation }
  
  after_update_commit { broadcast_replace_to "message_#{self.id}", locals: {message: self, user: ""} }

  before_create :confirm_participant

  def confirm_participant
    if self.room.private
      participant = Participant.where(user_id: self.user.id, room_id: self.room.id).first
      throw :abort unless participant
    end
  end

  def after_creation
    self.update(state: "delivered")
    broadcast_append_to room, locals: {user: ""}
  end
end
