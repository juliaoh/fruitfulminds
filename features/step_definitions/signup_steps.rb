Then /^(?:|I )should see "([^"]*)" in drop-down menu$/ do |text|
  page.all(:css, 'select#' + text).length.should == 1
end
