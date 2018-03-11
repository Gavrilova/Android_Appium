When(/^I swipe in the menu$/) do
  action = Appium::TouchAction.new.swipe(start_x: 0.01, start_y: 0.5, end_x: 0.9, end_y: 0.5, duration: 500)
  action.perform
end

Then(/^I see app menu$/) do
  find_element(id: "design_navigation_view").find_element(xpath: "//android.widget.CheckedTextView[@text='Area']")
  find_element(id: "design_navigation_view").find_element(xpath: "//android.widget.CheckedTextView[@text='Cooking']")
  find_element(id: "design_navigation_view").find_element(xpath: "//android.widget.CheckedTextView[@text='Currency']")
end

And(/^I select "([^"]*)" from menu$/) do |value|
  select_menu_item(value)
end

Then(/^I ground on "([^"]*)" screen$/) do |value|
  find_element(id: "toolbar").find_element(xpath: "//android.widget.TextView[@text='#{value}']")
end


And(/^I ground on Area screen$/) do
  if find_element(id: "toolbar").find_element(xpath: "//android.widget.TextView[@text='Area']").displayed? != true
    fail("Area text is absent on current screen!")
  end
end
