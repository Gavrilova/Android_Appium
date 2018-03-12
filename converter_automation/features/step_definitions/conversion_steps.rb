When (/^I see "([^"]*)" default checked in To column$/) do |value|

  if find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{value}']").attribute("checked") == "false"
    raise("#{value} is not default checked button!")
  end

end


Then (/^I see "([^"]*)" in header_value_to field$/) do |value|
  if find_element(id: "header_value_to").text != value
    raise("Header is not contain #{value}!")
  end
end


Then (/^I select "([^"]*)" radio button in To column$/) do |value|
  find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{value}']").click
end


And (/^I get "([^"]*)" in header_value_to field$/) do |value|

  if find_element(id: "header_value_to").text != value
    raise("Conversion result is wrong!")
  end
end
