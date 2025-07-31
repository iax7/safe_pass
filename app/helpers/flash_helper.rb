# frozen_string_literal: true

module FlashHelper
  def flash_class(type)
    case type
    when "notice" then "success"
    when "alert" then "danger"
    else
      ""
    end
  end
end
