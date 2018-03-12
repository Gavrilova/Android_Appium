And(/^I see checked "([^"]*)" radio button in From column$/) do |string|

  #assert that checked radio button in left column From is "string"
  if find_element(id: "radio_group_from").find_element(xpath: "//android.widget.RadioButton[@text='#{string}']").attribute("checked") != "true"
    raise("#{string} is not checked radio button!")
  end
end


And(/^I see "([^"]*)" in the From text field$/) do |value|
  if find_element(id: "header_value_from").text != "#{value}"
    raise("#{value} in the From field is differ than 1.0 ")
  end
end


When (/^I see "([^"]*)" default checked in To column$/) do |string|

  if find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{string}']").attribute("checked") == "false"
    raise("#{value} is not default checked button!")
  end

end


Then (/^I select "([^"]*)" radio button in To column$/) do |string|


  current_screen = get_source
  previous_screen = ""

  until (exists {find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{string}']")}) || (previous_screen == current_screen) do
    Appium::TouchAction.new.swipe(start_x: 0.5, start_y: 0.9, offset_x: 0.5, offset_y: 0.5, duration: 500).perform
    previous_screen = current_screen
    current_screen = get_source
  end

  if find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{string}']").displayed? == true
    find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{string}']").click
  else
    raise("#{string} wasn't fround in To column!")
  end


  #assert that we checked exact elem radio button in right column
  if find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{string}']").attribute("checked") != "true"
    raise("#{string} wasn't checked!")
  end
end


And (/^I see "([^"]*)" in header_value_to field$/) do |string|

  if find_element(id: "header_value_to").text != string
    raise("Conversion result is wrong!")
  end
end
