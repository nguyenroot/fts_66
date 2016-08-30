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

  def admin_logs
    f = File.open "#{Rails.root}/" + Settings.logs.admin_log_path, "r"
    admin_logs = Array.new
    f.each_line do |line|
      admin_logs.append line
    end
    admin_logs.last Settings.logs.last_ten
  end
end
