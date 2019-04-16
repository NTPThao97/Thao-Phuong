class UserSupport
  def user_types
    @user_types = Decentralization.pluck(:name, :id)
  end
end
