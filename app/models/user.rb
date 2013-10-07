class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name
  has_many :routines

  letsrate_rater

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.id = auth.uid
      user.name = auth.info.nickname
    end
  end

  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes'], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def graph_for_total_weight_over_time(exercise_id)
    array = [["Date", "Total Weight"]]
    b = Lift.where(:exercise_id => exercise_id)
    b.each do |lift|
      array << lift.lift_date_and_weight
    end
  array
  end

  def my_lifts
    array = []
    self.routines.each do |routine|
      array << routine.lifts
    end
    array.flatten
  end

  def dash
    array = []
    self.my_lifts.each do |lift|
      array << lift.dash_array
    end
    array
  end

end

