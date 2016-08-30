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

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object,
      child_index: "new_#{association}") do |builder|
        render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  def link_to_function(name, *args, &block)
    html_options = args.extract_options!.symbolize_keys
    function = block_given? ? update_page(&block) : args[0] || ""
    onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function}; return false;"
    href = html_options[:href] || "#"
    content_tag(:a, name, html_options.merge(href: href, onclick: onclick))
  end
end
