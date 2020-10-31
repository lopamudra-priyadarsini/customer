require 'rails_helper'

RSpec.describe User, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe 'validations' do 
    it { should validate_presence_of :gender }
  end

  describe User do
    
    it { is_expected.to have_one(:user_role) }
    it { is_expected.to have_one(:role).through(:user_roles) }
    
  end
end
