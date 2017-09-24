module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def description(page_description)
    content_for(:description) { page_description }
  end

  def keywords(page_keywords)
    content_for(:keywords) { page_keywords }
  end

  def image(page_image)
    content_for(:image) { page_image }
  end

  # def markdown(text)
  #   options = {
  #     filter_html:     true,
  #     hard_wrap:       true,
  #     link_attributes: { rel: 'nofollow', target: "_blank" },
  #     space_after_headers: true,
  #     fenced_code_blocks: true
  #   }
  #
  #   extensions = {
  #     autolink:           true,
  #     superscript:        true,
  #     disable_indented_code_blocks: true
  #   }
  #
  #   # renderer = Redcarpet::Render::HTML.new(options)
  #   # markdown = Redcarpet::Markdown.new(renderer, extensions)
  #
  #   markdown.render(text).html_safe
  # end
end
