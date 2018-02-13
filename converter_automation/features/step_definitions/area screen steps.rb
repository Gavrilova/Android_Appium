Given(/^I land on help popup$/) do
  puts("User lands on Help popup")
end

When(/^I click on Got it button$/) do
  puts("User clicks on Got it button")
end

Then(/^I land on Area screen$/) do
  puts("User lands on Area screen")
end

When(/^I click on Swap button$/) do
  puts("User clicks on Swap button")
end

Then(/^I see "([^"]*)" in From header$/) do |value|
  puts("From header value is " + value)
end

And(/^I see "([^"]*)" in To header$/) do |value|
  puts("To header value is #{value}")
end

And(/^I click on Clear button$/) do
  puts("User clicks on Clear button")
end

When(/^I enter "([^"]*)" to From field$/) do |value|
  puts("User enters value #{value}")
end

Then(/^I get "([^"]*)" in To field$/) do |value|
  puts("User sees value #{value} in result field")
end