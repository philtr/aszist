class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_ticket

  def index
    @comments = @ticket.comments
  end

  def create
    @comment = @ticket.comments.build(comment_params)
    @comment.user = current_user

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

  protected

  def comment_params
    params.require(:comment).permit(:body)
  end

  def load_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end
end
