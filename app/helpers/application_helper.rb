module ApplicationHelper
  def markdownify(text)
    raw ::Redcarpet.new(text, :smart, :filter_html, :hard_wrap).to_html
  end
end
