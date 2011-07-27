class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @comments = Comment.where(:ticket_id => params[:ticket_id])
  end
  def create
    @comment = Comment.create(params[:comment])
    @comment.user = current_user
    @comment.ticket = Ticket.find(params[:ticket_id])
    if @comment.save
      if params[:send_to_user] == "1"
        # TODO: send message via ActionMailer
        TicketMailer.agent_reply(@comment).deliver
        # render :text => "MESSAGE SENT TO USER>>> LOLJK NOT REALLY!\n\n#{Redcarpet.new(@comment.body).to_html}" and return
      end
      redirect_to(@comment.ticket)
    end
  end
  def update
  end
  def destroy
  end
end