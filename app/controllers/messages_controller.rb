class MessagesController < ApplicationController
    before_action :authenticate_user!
    
    def create
        @message = current_user.messages.create(body: msg_params[:body], room_id: params[:room_id]);

        # turbo_stream.append("messages", remote: true, partial: "messages/message", locals: {message: @message, user: current_user})
    end

    private

    def msg_params
        params.require(:message).permit(:body)
    end
end
