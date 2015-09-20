class InvitationsController < Devise::InvitationsController

  before_filter :update_sanitized_params, only: :update

  # PUT /resource/invitation
  def update
    respond_to do |format|
      format.js do
        invitation_token = Devise.token_generator.digest(resource_class, :invitation_token, update_resource_params[:invitation_token])
        self.resource = resource_class.where(invitation_token: invitation_token).first
        resource.skip_password = true
        resource.update_attributes update_resource_params.except(:invitation_token)
      end
      format.html do
        super
      end
    end
  end


  def create
    # new user
    user = User.find_by_email(params[:user][:email])

    group_id = params[:user][:group_id]

    email = params[:user][:email]

    group = Group.find(group_id)
    #make the group invite
    #when the user joins, it is accepted
    #otherwise, the invited user will see it on their page and be able to update or destroy
    GroupInvite.create(group_id: group_id, email: email)

    if not user
      #user doesn't exist, add to invited users, and then go from there
      self.resource = invite_resource
      resource_invited = resource.errors.empty?

      yield resource if block_given?

      if resource_invited
        if is_flashing_format? && self.resource.invitation_sent_at
          set_flash_message :notice, :send_instructions, :email => self.resource.email
        end
        respond_with resource, :location => after_invite_path_for(current_inviter)
      else
        respond_with_navigational(resource) { render :new }
      end
    else
      #user exists, add to group
      #send existing user the message
      UserMailer.group_invitation(user, group).deliver
      respond_with resource, :location => after_invite_path_for(current_inviter)
    end

  end

  protected

  def update_sanitized_params
    devise_parameter_sanitizer.for(:accept_invitation) do |u|
      u.permit(:first, :last, :password, :password_confirmation, :invitation_token, :avatar, :avatar_cache, :group_id)
    end
  end

  private
  def resource_params
     params.permit(user: [:first, :last, :password, :password_confirmation, :invitation_token, :avatar, :avatar_cache, :group_id])[:user]
  end
end