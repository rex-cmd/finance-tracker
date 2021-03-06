class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def stock_already_tracked?(ticker_symbol)
    stock = Stock.check_db(ticker_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end       
  
  def under_stock_limit?
        stocks.count<10
  end       
  def can_track_stock?(ticker_symbol) 
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end
  def user_already_followed?(first_name)
    friend=User.check_db(first_name)
    return false unless friend
    friends.where(id: friend.id).exists?
  end
  def can_follow_user?(first_name)
    !user_already_followed?(first_name)
  end
  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end

  def self.check_db(first_name)
    where(first_name: first_name).first
  end
end
