class Room < ApplicationRecord
    validates_uniqueness_of :name
    validates :name, presence: true

    scope :public_rooms, -> {
        where(private: false)
    }

    after_create_commit { append_if_public }
    after_destroy_commit { destroy_if_public }

    has_many :messages
    has_many :participants, dependent: :destroy

    def append_if_public
        broadcast_append_to "rooms" unless self.private
    end

    def destroy_if_public
        broadcast_remove_to "rooms" unless self.private
    end

    def self.create_private_room(users, room_name)
        single_room = Room.create(name: room_name, private: true)

        users.each do |user|
            Participant.create(user_id: user.id, room_id: single_room.id)
        end

        return single_room
    end
end