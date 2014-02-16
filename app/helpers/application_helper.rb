module ApplicationHelper
  include Redcarpet

  def flashy(flash)
    flash.map do |type, message|
      render "shared/flash/#{ type }", message: message
    end.join.html_safe
  end

  def logo(link_url = root_path)
    render "shared/logo", url: link_url
  end

  def markdownify(text)
    markdown = Markdown.new(Render::XHTML.new(:hard_wrap => true))
    raw Render::SmartyPants.render(markdown.render(text))
  end

end
