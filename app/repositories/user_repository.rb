class UserRepository
  def find_by_user_email
    User.find_by(email: user_email)
  end
end
