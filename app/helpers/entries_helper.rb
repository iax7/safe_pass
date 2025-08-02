module EntriesHelper
  def empty_entries_message
    content_tag(:h1, "No entries", class: "h-100 d-flex align-items-center justify-content-center")
  end
end
