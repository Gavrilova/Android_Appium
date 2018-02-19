And(/^I see "([^"]*)" in the From text field$/) do |value|
  if find_element(id: "header_value_from").text != "#{value}"
    raise("#{value} in the From field is differ than 1.0 ")
  end
end


Then(/^I find index checked radio button$/) do

  # header_To_text = find_element(id: "header_text_unit_to").text
  buttons = find_element(id: "radio_group_to").find_elements(class: "android.widget.RadioButton")
  buttons_after_click = buttons

  buttons_after_click.delete_at(1)


  3.times {
    i = rand(buttons_after_click.length)
    #select_radio_button(buttons_after_click.at(i))
    buttons_after_click.at(i).click
    puts(find_element(id: "header_text_unit_to").text)
    if find_element(id: "header_text_unit_to").text == ""
      raise("There is no results after convertions!")
    end

    convertion

    buttons_after_click.delete_at(i)
  }
end


Then(/^I select the next one radio button in the next column$/) do
  put("next step to code will continue")
end

Then(/^I see text in To header$/) do
  header_to_text = find_element(id: "header_text_unit_to").text
  puts("Header To text: " + header_to_text)
end