class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


	has_one :user_role
  has_one :role, through: :user_roles
  validates_presence_of :gender

  CREATE_KEYS = [:user_name, :email, :phone_number, :gender, :date_of_birth]
  UPDATE_KEYS = [:user_name, :phone_number] 

	# validates_uniqueness_of :mobile_number, message: "%{value} is already taken",
 #                                          if: proc { |user| user.mobile_number.present? }
 #  validates_numericality_of :mobile_number, message: 'must be a number',
 #                                            if: proc { |user| user.mobile_number.present? }
 #  validates_length_of :mobile_number, is: 10,
 #                                      message: 'must be 10 digit',
 #                                      if: proc { |user| user.mobile_number.present? }



end