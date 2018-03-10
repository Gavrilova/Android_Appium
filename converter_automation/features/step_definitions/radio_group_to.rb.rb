And(/^I see "([^"]*)" in the From text field$/) do |value|
  if find_element(id: "header_value_from").text != "#{value}"
    raise("#{value} in the From field is differ than 1.0 ")
  end
end


Then(/^I find index checked radio button$/) do

  column_to = counts_right_column_radio_buttons()

  column_to.delete_at(1)
  8.times {

    i = rand(column_to.length - 1)
    elem = column_to[i]
 #   puts("column_to.index(#{i}) = #{elem}")
    select_radio_button(elem)
    if (find_element(id: "header_text_unit_to").text == elem)
#      puts("Header:", find_element(id: "header_text_unit_to").text)
    else
      raise ("Header #{find_element(id: "header_text_unit_to").text}  should be #{elem}  !")
    end


    if find_element(id: "header_text_unit_to").text == ""
      raise("There is no results after conversions!")
    end

    conversion

    column_to.delete_at(i)
 #   puts("Remain radio button to test:", column_to.size)
    column_to.each do |v|
 #     puts v
    end
  }
end


Then(/^I select the next one radio button in the next column$/) do
  put("next step to code will continue")
end

Then(/^I see text in To header$/) do
  header_to_text = find_element(id: "header_text_unit_to").text
#  puts("Header To text: " + header_to_text)
end