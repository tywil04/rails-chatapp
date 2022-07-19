class Message < ApplicationRecord
  validates :body, presence: true
  validates :user, presence: true
  validates :room, presence: true

  belongs_to :user
  belongs_to :room

  after_create_commit { broadcast_append_to room, locals: {user: self.local_variables} }

  before_create :confirm_participant

  def confirm_participant
    if self.room.private
      participant = Participant.where(user_id: self.user.id, room_id: self.room.id).first
      throw :abort unless participant
    end
  end
end
