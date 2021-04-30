module BugsHelper
  def created_or_assigned_projects(parent, objects)
    return if current_user.manager? || objects.empty?
    concat (content_tag :div, class: 'd-flex-space-between' do
      concat content_tag :h2, "Your #{ current_user.qa? ? 'Created' : 'Assigned'} Bugs"
      concat show_if_qa create_link_button new_project_bug_path(@project.id)
    end)
    concat content_tag :div, '', class: 'line'
    render partial: 'bug', collection: objects, as: :bug
  end

  def assign_bug_form(parent, object)
    return unless policy(object).update?

    form_with model: [parent, object], class: 'mt-3' do |f|
      concat (content_tag :div ,class: 'form-group' do
        concat f.label :change_status
        if object.bug_type == 'feature'
          concat f.select :status, options_for_select(Bug::FEATURE_STATUS_MAP, object.status), {}, class: 'form-control'
        else
          concat f.select :status, options_for_select(Bug::BUG_STATUS_MAP, object.status), {}, class: 'form-control'
        end
      end)

      concat (content_tag :div, class: 'form-group' do
        f.submit :Change, class: 'btn'
      end)
    end
  end

  def screenshot_url(object)
    return unless object.screenshot.attached?

    image_tag url_for(object.screenshot), class: 'media-object img-thumbnail', width: '100%'
  end
end
