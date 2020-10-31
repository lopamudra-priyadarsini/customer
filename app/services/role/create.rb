class Role::Create < ApplicationService

  def initialize(options)
    @create_params = options.slice(*Role::CREATE_KEYS)
    super(options)
  end

  def call
    create
  end

  def create
    role = Role.create(@create_params)
    if role
      success_response(message: 'Role succesfully created', data:  {role: role})
    else
      error_response(message: role.errors.to_sentence, data:  {role: role})
    end
  end
end