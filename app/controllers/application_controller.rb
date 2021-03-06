class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    params[:user][:locale] = I18n.locale if params[:user].present?
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name tel subdomain locale])
  end

  def set_locale
    return I18n.locale = ENV['DEVELOPMENT_LOCALE'].to_sym if ENV['DEVELOPMENT_LOCALE'].present?

    I18n.locale = case tld
                  when 'it'
                    :it
                  else
                    :en
                  end
  end

  def after_sign_in_path_for(resource)
    cv_section_path(resource.subdomain)
  end

  def tld
    @tld ||= request.host.split('.').last
  end

  def redirect_to_root_domain
    root_domain = locale.to_s == 'en' ? ENV['EN_SERVER_HOST'] : ENV['IT_SERVER_HOST']
    redirect_to root_domain
  end
end
