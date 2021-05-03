# frozen_string_literal: true

module ApplicationHelper
  def nav_link_with_method_and_icon(text, path, method, icon_class)
    link_to path, method: method do
      concat tag.i('', class: "fa fa-#{icon_class} mr-1")
      concat tag.span(text)
    end
  end

  def show_if_signed_in(content)
    content if user_signed_in?
  end

  def show_unless_signed_in(content)
    content unless user_signed_in?
  end

  def show_if_manager(content)
    content if current_user&.manager?
  end

  def show_if_qa(content)
    content if current_user&.qa?
  end

  def create_link_button(path)
    link_to path, class: 'move-to-bottom' do
      tag.button('+', class: 'btn square-btn')
    end
  end
end
