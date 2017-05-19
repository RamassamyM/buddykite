module ApplicationHelper

  def render_order_form(order)
    @order = order
    render 'shared/review_form'
  end

  def compute_order_price(order)
    gear_price(order) * ((order.end_at - order.start_at).to_i + 1 )
  end

  def gear_price(order)
    eval(order.infos)[:gear_price]
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

  private

  def user_credential_pages
    (controller_name == 'registrations') || (controller_name == 'sessions') || (controller_name == 'passwords')
  end

  def is_home
    controller_name == "pages" && action_name == "home"
  end

end
