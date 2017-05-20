module ApplicationHelper

  def compute_order_price(order)
    order.infos.to_i * ((order.end_at - order.start_at).to_i + 1 )
  end

  def remove_footer_from_home
    "hidden" if is_home
  end

  def add_navbar_margin
    if is_home
    else
      "page-wrapper-navbar-margin"
    end
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

  def add_navbar_unless_homepage
    render 'shared/navbar' unless is_home
  end

  def avatar_to_display
    if current_user.photo?
      cl_image_tag current_user.photo.path, height: 40, width: 40, crop: :fill, class: "avatar-medium right-marged dropdown-toggle", id: "navbar-wagon-menu", "data-toggle" => "dropdown"
    else
      image_tag 'user.png', class: "avatar-medium dropdown-toggle", id: "navbar-wagon-menu", "data-toggle" => "dropdown"
    end
  end

  private

  def user_credential_pages
    (controller_name == 'registrations') || (controller_name == 'sessions') || (controller_name == 'passwords')
  end

  def is_home
    controller_name == "pages" && action_name == "home"
  end

end
