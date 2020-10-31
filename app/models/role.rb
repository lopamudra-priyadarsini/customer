class Role < ApplicationRecord

	has_many :user_roles
  has_many :users, :through => :user_roles

  validates_uniqueness_of :role_name, :role_code

  CREATE_KEYS = [:role_name, :role_code]
  UPDATE_KEYS = [:role_name] 
  #updating the code might create conflicts in dependent codes as the role_id and role_code will be used for references.
end
