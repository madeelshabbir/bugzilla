# frozen_string_literal: true

module ProjectsHelper
  def creator_policy_check(object, content)
    content if policy(object).creator?
  end

  def add_user_form(object_id, users)
    form_with url: project_project_users_path(object_id), class: 'rem-form', validate: true do |f|
      if users.count.positive?
        concat(
          (tag.div(class: 'form-group') do
            f.submit(:Add, class: 'btn')
          end)
        )
      end

      concat(
        (tag.div(class: 'scroll-able') do
          render partial: 'project_users/user_check_box', collection: users, as: :user, locals: { form: f }
        end)
      )
    end
  end
end
