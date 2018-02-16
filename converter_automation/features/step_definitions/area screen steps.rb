Given(/^I land on Help popup$/) do
  text("Help")
end

When(/^I click on Got it button$/) do
  find_element(id: "button1").click
end

Then(/^I land on "([^"]*)" screen$/) do |value|
  if (find_element(id: "toolbar").find_element(xpath: "//android.widget.TextView[@text='#{value}']").displayed? == true)
  else
    fail("#{value} text is absent on current screen!")
  end
end

When(/^I click on Swap button$/) do
    beforeSwap_From_header = find_element(id: "header_text_unit_from").text
    beforeSwap_To_header = find_element(id: "header_text_unit_to").text

  find_element(id: "fab").click
    afterSwap_From_header = find_element(id: "header_text_unit_from").text
    afterSwap_To_header = find_element(id: "header_text_unit_to").text
    if afterSwap_From_header != beforeSwap_To_header
      fail("After swap From header should be #{beforeSwap_To_header}, instead of #{afterSwap_From_header}")
    end
    if afterSwap_To_header != beforeSwap_From_header
      fail("After swap To header should be #{beforeSwap_From_header}, instead of #{afterSwap_To_header}")
    end
end

Then(/^I see "([^"]*)" in From header$/) do |value|
  actual_value = find_element(id: "header_text_unit_from").text

  if actual_value != value
    fail("Expected value is #{value}, but actual value was #{actual_value}")
  end
end

And(/^I see "([^"]*)" in To header$/) do |value|
  actual_value = find_element(id: "header_text_unit_to").text

  if actual_value != value
    fail("Expected value is #{value}, but actual value was #{actual_value}")
  end
end

And(/^I click on Clear button$/) do
  #we need to assert that there is no text in header_value_from field
  value_From = find_element(id: "header_value_from").text
    if value_From != nil
      find_element(id: "menu_clear").click
    end
  #assert that header_value_From field is empty and header_value_To is "0"
  after_value_From = find_element(id: "header_value_from").text
  after_value_To = find_element(id: "header_value_to").text
  if after_value_From != ""
    fail("header_value_From field doesn't clear after tapping Clear button")
  end
  if after_value_To != "0"
    fail("header_value_To field doesn't contain 0 after tapping Clear button")
  end

end

When(/^I enter "([^"]*)" to From field$/) do |value|
  find_element(id: "header_value_from").send_keys(value)
end

Then(/^I get "([^"]*)" in To field$/) do |value|
  actual_value = find_element(id: "header_value_to").text
  if actual_value != value
    fail("Expected value is #{value}, but actual value was #{actual_value}")
  end
end

When(/^I click on From field$/) do
  find_element(id: "header_value_from").click
end

And(/^I press "([^"]*)" on soft keyboad$/) do |value|
  initial_value = value
  digits = value.split("")
  digits.each do |key|
  digit = Integer(key)
  press_keycode 7 + digit
  end
  header_value_from = find_element(id: "header_value_from").text
  if header_value_from != initial_value
    fail("Inputted value #{header_value_from} doesn't match initial value #{initial_value}")
  end
end

When(/^I select "([^"]*)" from left column$/) do |value|
  #make sure that we have checked Sq Metre radio button in the right column
  if find_element(id: "header_text_unit_to").text != "Sq Metre"
    find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='Sq Metre']").click
  end
  #make sure that header_value_from = "1.0" to expect "10000" after clicking to the Hectare in the left column
  if find_element(id: "header_value_from").text !="1.0"
    fail("Value in the header_value_to will not be 10000")
  end

  find_element(id: "radio_group_from").find_element(xpath: "//android.widget.RadioButton[@text='#{value}']").click
   #make sure that "Hectare" radio buton in left column checked
  if find_element(id: "radio_group_from").find_element(xpath: "//android.widget.RadioButton[@text='#{value}']").attribute("checked") != "true"
    fail("Hectare radio button from left column doesn't checked!")
  end
end