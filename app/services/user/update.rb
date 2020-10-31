class User::Update < ApplicationService
  
  def initialize(options)
    @user = User.find_by(id: options[:id])
    @update_params = options.slice(*User::UPDATE_KEYS)
    super(options)
  end

  def call
    return error_response(message: 'User not found') unless @user.present?
    update
  end

  def update
    if current_user.can_update?
      if @user.update(@update_params)
        success_response(message: 'User succesfully updated', data:  {user: @user})
      else
        error_response(message: @user.errors.full_messages.to_sentence)
      end
    end
  end

  private
    def can_update?
      authorize! :update, @user
    end
end