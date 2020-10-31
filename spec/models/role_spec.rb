require 'rails_helper'

RSpec.describe Role, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe Role do
    
    it { is_expected.to have_many(:user_roles) }
    it { is_expected.to have_many(:users).through(:user_roles) }
    
  end
    
end
