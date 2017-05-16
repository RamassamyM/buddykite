module ApplicationHelper
  def navbar_home_change
    "navbar-transparent" if is_home
  end

  private
    def is_home
      controller_name == "pages" && action_name =="home"
    end
end
