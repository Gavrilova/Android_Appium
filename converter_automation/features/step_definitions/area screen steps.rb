Given(/^I land on help popup$/) do
  text("Help")
end

When(/^I click on Got it button$/) do
  find_element(id: "button1").click
end

Then(/^I land on Area screen$/) do
  text("Area")
end

When(/^I click on Swap button$/) do
  find_element(id: "fab").click
end

Then(/^I see "([^"]*)" in From header$/) do |value|
  actual_value = find_element(id: "header_text_unit_from").text
  puts("Expected value is #{value}")
  puts("Actual value is #{actual_value}")
end

And(/^I see "([^"]*)" in To header$/) do |value|
  actual_value = find_element(id: "header_text_unit_to").text
  puts("Expected value is #{value}")
  puts("Actual value is #{actual_value}")
end

And(/^I click on Clear button$/) do
  find_element(id: "menu_clear").click
end

When(/^I enter "([^"]*)" to From field$/) do |value|
  find_element(id: "header_value_from").send_keys(value)
end

Then(/^I get "([^"]*)" in To field$/) do |value|
  actual_value = find_element(id: "header_value_to").text
  puts("Expected value is #{value}")
  puts("Actual value is #{actual_value}")
end