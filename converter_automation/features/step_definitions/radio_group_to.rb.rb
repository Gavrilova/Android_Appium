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
  8.times {
    i = rand(buttons_after_click.length)
    buttons_after_click.at(i).click
    puts(find_element(id: "header_text_unit_to").text)
    if find_element(id: "header_text_unit_to").text == ""
      raise("There is no results after convertions!")
    end

    header_to = find_element(id: "header_text_unit_to").text
    value_from = find_element(id: "header_value_from").text
    sq_km = value_from.to_f
    mt = Math.sqrt(sq_km) * 1000

    result = 0
    if header_to == "Sq Metre"
      result = (mt) ** 2
    end
    if header_to == "Sq Centimetre"
      result = (mt * 100) ** 2
    end

    if header_to == "Hectare"
      result = (sq_km * 100)
    end

    if header_to == "Sq Mile"
      result = sq_km * ((100 * 1000) / (1760 * 36 * 2.54)) ** 2
    end

    if header_to == "Sq Yard"
      result = sq_km * (1000 * 100 / (36 * 2.54)) ** 2
    end

    if header_to == "Sq Foot"
      result = sq_km * (1000 * 100 / (12 * 2.54)) ** 2
    end

    if header_to == "Sq Inch"
      result = sq_km * ((1000 * 100 / 2.54) ** 2)

    end

    if header_to == "Acre"
      result = sq_km * (((100 * 1000) / (36 * 2.54)) ** 2) / 4840
    end
    if header_to == "Sq Kilometre"
      result = 1
    end
    value_to = (find_element(id: "header_value_to").text).to_f
    result_sprintf = sprintf("%.4f", result).to_f
    if value_to != result_sprintf
      raise("Conversion result is wrong!")
    end
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