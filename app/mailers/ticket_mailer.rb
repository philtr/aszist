class TicketMailer < ActionMailer::Base
  config = Hashie::Mash.new(YAML::load(ERB.new(File.read('config/mailman.yml')).result))  
  default :return_path => "#{config.email.support.user}@#{config.email.support.domain}"
  add_template_helper(ApplicationHelper)
  
  def agent_reply(comment)
    @comment = comment
    @to = "#{@comment.ticket.user} <#{@comment.ticket.user.email}>"
    @from = "#{@comment.user} <#{@comment.user.email}>"
    mail(:to => @to, :from => @from, :subject => "Re: #{@comment.ticket.subject}")
  end
  
  class Preview < MailView
    def agent_reply
      bob = User.new(
        :email => "bob@example.com",
        :first_name => "Bob",
        :last_name => "Jones")
      steve = User.new(
          :email => "steve@example.com",
          :first_name => "Steve",
          :last_name => "Saint",
          :role => 1)
      ticket = Ticket.new(
        :subject => "Example issue title thingy",
        :body => "Help! I'm having trouble figuring this crap out.\n\nThanks, Bob")
      ticket.user = bob
      ticket.agent = steve
      comment = Comment.new(
        :body => "Ok, let's figure this out together. Can you describe your problem for me?\n\nSteve",
        :sent_to_user => true)
      comment.ticket = ticket
      comment.user = steve
      ::TicketMailer.agent_reply(comment)
    end
  end
end
