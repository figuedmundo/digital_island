module ApplicationHelper

  # def default_password
  #   'password'
  # end

  def full_title(page_title)
    base_title = "Digital Island"
    ( page_title.nil? || page_title.empty? ) ? base_title : "#{base_title} | #{page_title}"
  end

end
