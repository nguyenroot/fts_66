module ApplicationHelper
  def full_title page_title = ""
    base_title = I18n.t "title"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def get_pagination_element_index collection, element,
    page_elements_count = Settings.pagination.size
    collection.index(element) + 1 +
      (collection.current_page - 1) * page_elements_count
  end
end
