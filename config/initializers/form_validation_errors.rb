# frozen_string_literal: true

# https://guides.rubyonrails.org/configuring.html#config-action-view-field-error-proc
# or in config/application.rb:
#   config.action_view.field_error_proc = Proc.new
ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  if html_tag.start_with?("<label")
    html_tag.html_safe
  else
    fragment = Nokogiri::HTML::DocumentFragment.parse(html_tag)
    element = fragment.children.first

    if element
      existing_class = element["class"] || ""
      element["class"] = existing_class.split.append("input-with-errors").uniq.join(" ")
      fragment.to_html.html_safe
    else
      html_tag.html_safe
    end
  end
end
