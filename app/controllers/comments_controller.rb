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
      if @comment.sent_to_user?
        TicketMailer.agent_reply(@comment).deliver
      end
      redirect_to(@comment.ticket)
    end
  end
  def update
  end
  def destroy
  end
end