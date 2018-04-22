module CommentsHelper
  def find_user_name user_id
    user = User.find_by(id: user_id)
    return t("users.anonymous") unless user
    user.name
  end
end
