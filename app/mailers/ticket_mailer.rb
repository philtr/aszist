class TicketMailer < ActionMailer::Base
  add_template_helper ApplicationHelper

  def agent_reply(comment)
    @comment = comment
    @to = "#{@comment.ticket.user} <#{@comment.ticket.user.email}>"
    @from = "#{@comment.user} <#{@comment.user.email}>"
    mail(:to => @to, :from => @from, :subject => "Re: #{@comment.ticket.subject}")
  end

  def notify_agent(ticket)
    config = Hashie::Mash.new(YAML::load(ERB.new(File.read('config/mailman.yml')).result))
    @ticket = ticket
    @to = "#{@ticket.agent} <#{@ticket.agent.email}>"
    @from = "#{@ticket.user} <#{@ticket.user.email}>"
    @reply_to = "#{config.email.support.user}+#{@ticket.token}@#{config.email.support.domain}"
    mail(:to => @to, :from => @from, :return_path => @reply_to,
      :subject => "[aszist] #{@ticket.subject}")
  end
end
