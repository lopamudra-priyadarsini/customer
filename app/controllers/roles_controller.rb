class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  # POST /roles
  # POST /roles.json
  def create
    response = Role::Create.call(role_params)
    if response.success?
      success_response(message: response.status_message, http_status: 202, data: response.data)
    else
      error_response(message: response.status_message, data: response.data)
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    response = Role::Update.call(role_params)
    if response.success?
      success_response(message: response.status_message, http_status: 202, data: response.data)
    else
      error_response(message: response.status_message, data: response.data)
    end
  end

  #Deleting a role can cause big dependency problems. Commented it so that no one can hit this method even by mistake.
  # def destroy
  #   @role.destroy
  #   respond_to do |format|
  #     format.html { redirect_to roles_url, notice: 'Role was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def role_params
      params.fetch(:role, {})
    end
end
