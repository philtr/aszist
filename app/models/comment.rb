class Comment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user

  before_create :strip_out_reply_and_signature

  def self.sent_to_user
    where(sent_to_user: true)
  end

  private

  def strip_out_reply_and_signature
    [
      # Reply Delimiters
      /^(On\s)?(.+?)\swrote:$/i,
      /^-----Original Message-----$/i,
      /^From:\s/i,
      /^_+$/,
      # Signature Delimiters
      /^(Sincerely|Thanks|Regards|Cheers|Best|Love),\n(.*?)\n/i,
      /^-+$/,
      /^Sent from my (iPhone|iPad|iPod(\stouch)?|Blackberry)(.*?)/i
    ].each {|d| self.body = self.body.split(d).first }
  end

end
