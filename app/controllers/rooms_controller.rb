class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.public_rooms
    @users = User.all_except(current_user)

    render "index"
  end

  def create
    @room = Room.create(name: params["room"]["name"])
  end

  def show
    @single_room = Room.find(params[:id])
    @rooms = Room.public_rooms
    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc) 
    @users = User.all_except(current_user)
    
    render "index"
  end

  def destroy
    Message.where(room_id: params[:id]).each do |message|
      message.delete()
    end
    Room.destroy(params[:id])
  end
end
