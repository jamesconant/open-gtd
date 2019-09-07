class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lists, dependent: :destroy
  has_many :items, through: :lists do
    def without_deleted
      where("lists.name != 'Deleted'")
    end

    def only_deleted
      where("lists.name = 'Deleted'")
    end
  end
end
