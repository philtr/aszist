class Comment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user

  before_create :strip_out_reply_and_signature

  def previous_comments
    ticket.comments.where("id != ?", id).newest_first
  end

  def self.newest_first
    order("created_at DESC")
  end

  def self.sent_to_user
    where(sent_to_user: true)
  end

  private

  def delimiters
    [ /^\d#{4}-\d{2}-\d{2} \d{2}:\d{2} \w{3}-\d{2}:\d{2}/, # Gmail
      /^(On\s)?(.+?)\swrote:$/i, # Apple Mail & Aszist
      /^Date:\s\w{3},\s\d\d\s\w{3}\s\d{4}\s\d\d:\d\d:\d\d\s-\d{4}$/, # Outlook.com
      /^-----Original Message-----$/i,
      /^From:\s/i,
      /^[_-]+$/,
      /^(Sincerely|Thanks|Regards|Cheers|Best|Love),?$/i,
      /^[-–—]?\s?\w+$/, # - Name
      /^-+$/,
      /^Sent from my (iPhone|iPad|iPod(\stouch)?|Blackberry)/i ]
  end

  def strip_out_reply_and_signature
    self.body = delimiters.inject(self.body) do |body, delimiter|
      body.force_encoding("UTF-8").
        encode("UTF-8", invalid: :replace).
        split(delimiter).
        first.chomp
    end
  end

end
