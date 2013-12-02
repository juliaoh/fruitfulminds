Then /I should see "(.*)" before I see "(.*)"/ do |e1, e2|
  assert page.body.index(e1) < page.body.index(e2)
end
