module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the (FruitfulMinds )?home\s?page$/
      '/'
    when /^the login page$/
      '/login'
    when /^the portal page$/
      '/portal'
    when /^the historical report page/ then new_historical_path
    when /^the historical results page/ then '/historical'
    when /^the Add New School page$/ then new_school_path
    when /^the Add New College page$/ then new_college_path
    when /^the All Schools page$/ then schools_path
    when /^the All Colleges page$/ then colleges_path
    when /^the Create New Administrator page$/ then new_admin_path
    when /^the courses page$/ then portal_path
    when /^the reports page$/ then '/reports'
    when /^the generate report page$/ then '/reports/new'
    when /^the survey templates page$/ then '/survey_template'
    when /^the new survey template page$/ then new_survey_template_path
    when /^the edit survey template page$/ then edit_survey_template_path
    when /^the logout page$/ then logout_path
    when /^the edit user page for user (.*)$/ then edit_user_path($1)
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
