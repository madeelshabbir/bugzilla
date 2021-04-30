module ProjectsHelper
  def creator_policy_check(object, content)
    content if policy(object).creator?
  end

  def add_user_form(object_id)
    form_with url: project_add_user_path(object_id), class: 'rem-form' do |f|
      concat(
        (content_tag :div, class: 'form-group' do
          f.submit(:Add, class: 'btn')
        end)
      ) if @available_users.count > 0

      concat(
        (content_tag :div, class: 'scroll-able' do
          render partial: 'project_users/user_check_box', collection: @available_users, as: :user, locals: {form: f}
        end)
      )
    end
  end
end
