class Room < ApplicationRecord
    validates_uniqueness_of :name

    scope :public_rooms, -> {
        where(private: false)
    }

    after_create_commit { broadcast_if_public }

    has_many :messages
    has_many :participants, dependent: :destroy

    def broadcast_if_public
        broadcast_append_to "rooms" unless self.private
    end

    def self.create_private_room(users, room_name)
        single_room = Room.create(name: room_name, private: true)

        users.each do |user|
            Participant.create(user_id: user.id, room_id: single_room.id)
        end

        return single_room
    end
end
