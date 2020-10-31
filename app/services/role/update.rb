class Role::Update < ApplicationService
  
  def initialize(options)
    @role = Role.find_by(id: options[:id])
    @update_params = options.slice(*Role::UPDATE_KEYS)
    super(options)
  end

  def call
    return error_response(message: 'Role not found') unless @role.present?
    update
  end

  def update
    if @role.update(@update_params)
      success_response(message: 'Role succesfully updated', data:  {role: @Role})
    else
      error_response(message: @role.errors.full_messages.to_sentence)
    end
  end
end