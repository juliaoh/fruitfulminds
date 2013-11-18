Given /I infinite loop/ do
  sleep(9001)
end

Given /^the page should not contain the "([^"]*)" field$/ do |value|
  page.should_not have_field(value)
end

