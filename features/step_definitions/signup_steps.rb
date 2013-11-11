Then /^(?:|I )should see "([^"]*)" in drop-down menu$/ do |text|
  page.all(:css, 'select#' + text).length.should == 1
end

Then /^I should see the Terms of Service on a new page$/ do
  page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
  current_path = URI.parse(current_url).path
  correct_path = URI.parse("/services").path
  if current_path.respond_to? :should
    current_path.should == correct_path
  else
    assert_equal correct_path, current_path
  end
end
