class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :authenticate_scope!, only: [:show, :edit, :update, :destroy]

  protected

  def after_sign_up_path_for(resource)
    resource.avatar.present? ? '/preview' : '/'
  end
end
