module ProjectUsersHelper
  def show_if_creator_not_manager_row(object, user, content)
    content if policy(object).remove_user_view?(user)
  end
end
