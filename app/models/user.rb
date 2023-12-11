class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :demonstrations, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :user_types, dependent: :destroy
  has_many :user_topics, dependent: :destroy
  has_many :topics, through: :user_topics
  has_many :types, through: :user_types

  has_one_attached :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
