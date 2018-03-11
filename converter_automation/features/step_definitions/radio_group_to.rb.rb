And(/^I see "([^"]*)" in the From text field$/) do |value|
  if find_element(id: "header_value_from").text != "#{value}"
    raise("#{value} in the From field is differ than 1.0 ")
  end
end


Then(/^I find index checked radio button$/) do

  column_to = counts_right_column_radio_buttons()
  header_value_to=[1, 1000000, 10000000000, 100, 0.3861, 1195990.0463, 10763910.4167, 1550003100.0062, 247.1054]
  if !(column_to.length == header_value_to.length)
    raise("We couldn't compare arrays length!")
  end

  #we need to delete "Sq Metre" radio button from array because it's default checked radio button.
  # before deleting we need to confirm its correct conversion also.
  conversion(header_value_to[1])

  column_to.delete_at(1)
  header_value_to.delete_at(1)
  3.times {

    i = rand(column_to.length - 1)
    elem = column_to[i]
    elem_value = header_value_to[i]
 #  puts("column_to.index(#{i}) = #{elem}")
    select_radio_button(elem)
    if !(find_element(id: "header_text_unit_to").text == elem)
      raise ("Header #{find_element(id: "header_text_unit_to").text}  should be #{elem}  !")
    end

    conversion(elem_value)

    column_to.delete_at(i)
    header_value_to.delete_at(i)
  }
end

Then(/^I see text in To header$/) do
  #assert that Sq Metre is default checked button
  elem = find_element(id: "radio_group_to")
             .find_elements(class: "android.widget.RadioButton")[1]
  if (elem).attribute("checked") == "false"  || (elem.text() != "Sq Metre")
    raise("Sq Metre is not default checked button!")
  end

  #assert that checked button and header in To column are the same.
  if !(elem.text == find_element(id: "header_text_unit_to").text)
    raise("Header doesn't correspond checked button in column To!")

  end
  end

