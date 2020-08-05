# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_locale
  include SessionsHelper
  include AuthorsHelper
  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
                  locale : I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
