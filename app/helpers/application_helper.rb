module ApplicationHelper
  def remove_footer_from_home
    "hidden" if is_home
  end

  def navbar_home_change
    if is_home
      "hidden"
    else
      "navbar-wagon-fixed"
    end
  end

  def hide_search_bar
    "hidden" if user_credential_pages
  end

  private

  def user_credential_pages
    controller_name == 'devise/session' || 'devise/passwords' || 'devise/registration'
  end

  def is_home
    controller_name == "pages" && action_name == "home"
  end

end
