module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_pathologist
  end

  protected
  def check_pathologist
    if current_laboratory
      flash.clear
      # if you have rails_admin. You can redirect anywhere really
      redirect_to(home_path) and return
    elsif current_pathologist
      flash.clear
      # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
      redirect_to(home_path) and return
    end
  end
end
