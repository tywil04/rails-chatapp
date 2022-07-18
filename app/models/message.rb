class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create_commit { broadcast_append_to room }

  before_create :confirm_participant

  def confirm_participant
    return unless room.private
    
    participant = Participant.where(user_id: self.user.id, room_id: self.room.id).first
    throw :abort unless participant
  end
end
