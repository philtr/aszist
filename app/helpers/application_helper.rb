module ApplicationHelper
  include Redcarpet
  def markdownify(text)
    markdown = Markdown.new(Render::XHTML.new(:hard_wrap => true))
    raw Render::SmartyPants.render(markdown.render(text))
  end
end
