#require "appium_lib"
require 'appium_lib'
require 'selenium-webdriver'
require 'selenium/webdriver'


def caps
  {caps: {
      deviceName: "Name",
      platformName: "Android",
      app: (File.join(File.dirname(__FILE__), "ultimate_converter.apk")),
      appPackage: "com.physphil.android.unitconverterultimate",
      appActivity: "com.physphil.android.unitconverterultimate.MainActivity",
      newComandTimeout: "3600"
  }}
end

Appium::Driver.new(caps, true)
Appium.promote_appium_methods Object

def select_menu_item(value)
  #Selenium::WebDriver.
  #puts("location:")
  #puts(find_element(class: "android.widget.ImageButton").location)
  # puts(find_element(class: "android.widget.ImageButton").rect)
  width = (find_element(class: "android.widget.ImageButton").rect.width) / 2
  height = ((find_element(class: "android.widget.ImageButton").rect.height) / 2)
  # + (find_element(id: "statusBarBackground").rect.height)
  #puts(width)
  #puts(height)

  action = Appium::TouchAction.new.press(x: "#{width}", y: "#{height}").wait(5).release
  action.perform

  current_screen = get_source
  previous_screen = ""

  until (exists {find_element(id: "design_navigation_view").find_element(xpath: "//android.widget.CheckedTextView[@text='#{value}']")}) || (previous_screen == current_screen) do
    #Appium::TouchAction.new.swipe(start_x: 0.1, start_y: 0.8, end_x: 0.1, end_y: 0.2, duration: 500).perform

    x1 = (0.1 * find_element(id: "design_navigation_view").rect.width).round
    x2 = x1
    y1 = (0.8 * find_element(id: "design_navigation_view").rect.height).round
    y2 = (0.2 * find_element(id: "design_navigation_view").rect.height).round
    puts(x1, x2, y1, y2)
    #action = Appium::TouchAction.new.swipe(start_x: 200, start_y: 380, offset_x: 200, offset_y: 90, duration: 500)
    action = Appium::TouchAction.new.swipe(start_x: "#{x1}", start_y: "#{y1}", offset_x: "#{x2}", offset_y: "#{y2}", duration: 500)
    action.perform

    #action = Appium::TouchAction.new.swipe(start_x: 0.1, start_y: 0.8, offset_x: 0.1, offset_y: 0.2, duration: 500)
    previous_screen = current_screen
    current_screen = get_source
  end

  if exists {find_element(id: "design_navigation_view").find_element(xpath: "//android.widget.CheckedTextView[@text='#{value}']")}
    find_element(id: "design_navigation_view").find_element(xpath: "//android.widget.CheckedTextView[@text='#{value}']").click
  else
    fail("Element #{value} was not found in menu")
  end
end


def swipe_down(elem)
  current_screen = get_source
  previous_screen = ""

  until (exists {find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{elem}']")}) || (previous_screen == current_screen) do
    #Appium::TouchAction.new.swipe(start_x: 0.5, start_y: 0.8, end_x: 0.5, end_y: 0.2, duration: 500).perform
=begin
    radio_group_to_rect = find_element(id: "radio_group_to").rect
    puts("radio_group_to: ", radio_group_to_rect)
    radio_group_from_rect = find_element(id: "radio_group_from").rect
    header_conversion_rect = find_element(id: "header_conversion").rect
    puts("header_conversion rect: ", header_conversion_rect)
    puts("header_conversion location: ", find_element(id: "header_conversion").location)
    toolbar_rect = find_element(id: "toolbar").rect
    puts("toolbar rect: ", toolbar_rect)
    puts("toolbar location: ", find_element(id: "toolbar").location)
    x1 = (radio_group_from_rect.width + 0.5 * radio_group_to_rect.width).round
    x2 = x2
    y1 = (0.5 * radio_group_to_rect.height + header_conversion_rect.height + toolbar_rect.height).round
    y2 = (0.3 * radio_group_to_rect.height + header_conversion_rect.height + toolbar_rect.height).round
    puts("down: ", x1, y1, y2)
=end
    #Appium::TouchAction.new.swipe(start_x: "#{x1}", start_y: "#{y1}", offset_x: "#{x2}", offset_y: "#{y2}", duration: 500).perform
    #Appium::TouchAction.new.swipe(start_x: 1310, start_y: 800, offset_x: 1310, offset_y: 500, duration: 500).perform
    Appium::TouchAction.new.swipe(start_x: 0.5, start_y: 0.9, offset_x: 0.5, offset_y: 0.5, duration: 500).perform
    puts("I'm swiping down")
    previous_screen = current_screen
    current_screen = get_source
  end

  if exists {find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{elem}']")}
    find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{elem}']").click
    result = true
  else
    result = false
    puts("Element wasn't found after swiping down")
  end
  return result
end

def swipe_up(elem)
  current_screen = get_source
  previous_screen = ""
  if (exists {find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{elem}']")})
    puts("Element is here! ")
  end

  until (exists {find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{elem}']")}) || (previous_screen == current_screen) do

=begin
    #Appium::TouchAction.new.swipe(start_x: 0.5, start_y: 0.2, end_x: 0.5, end_y: 0.8, duration: 500).perform
    radio_group_to_rect = find_element(id: "radio_group_to").rect
    radio_group_from_rect = find_element(id: "radio_group_from").rect
    header_conversion_rect = find_element(id: "header_conversion").rect
    puts("header_conversion rect: ", header_conversion_rect)
    puts("header_conversion location: ", find_element(id: "header_conversion").location)
    toolbar_rect = find_element(id: "toolbar").rect
    puts("toolbar rect: ", toolbar_rect)
    puts("toolbar location: ", find_element(id: "toolbar").location)
    x1 = (radio_group_from_rect.width + 0.5 * radio_group_to_rect.width).round
    x2 = x2
    y1 = (0.2 * radio_group_to_rect.height + header_conversion_rect.height + toolbar_rect.height).round
    y2 = (0.8 * radio_group_to_rect.height + header_conversion_rect.height + toolbar_rect.height).round
    puts("up: ", x1, y1, y2)
    Appium::TouchAction.new.swipe(start_x: "#{x1}", start_y: "#{y1}", offset_x: "#{x2}", offset_y: "#{y2}", duration: 500).perform
=end
    Appium::TouchAction.new.swipe(start_x: 0.5, start_y: 0.5, offset_x: 0.5, offset_y: 0.9, duration: 500).perform
    puts("I'm swiping up")
    previous_screen = current_screen
    current_screen = get_source
  end

  if exists {find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{elem}']")}
    find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{elem}']").click
    result = true
  else
    result = false
    puts("Element wasn't found after swiping up")
  end
  return result
end


def select_radio_button(elem)
  value_down = swipe_down(elem)
  puts("value_down #{value_down}")
  if !(value_down)
    puts("trying to reach by swiping up" + elem)
    value_up = swipe_up(elem)
    puts("value up: #{value_up}")
    (puts "header_text_unit_to : #{find_element(id: "header_text_unit_to").text}")

  else
    if (value_up == false)
      raise ("Element wasn't found in right column!")
    end
  end
end


def counts_right_column_radio_buttons()
  current_screen = get_source
  previous_screen = ""
  elements = []
  array = find_element(id: "radio_group_to").find_elements(:class, "android.widget.RadioButton")
  array.each do |v|
    elements.push(v.text)
  end
=begin
  puts("Elements before swipe:")
  elements.each do |b|
    puts(b)
  end
=end

  until (exists {find_element(id: "radio_group_to")
                     .find_element(xpath: "//android.widget.RadioButton[@text='Acre']")}) || (previous_screen == current_screen) do
    #Appium::TouchAction.new.swipe(start_x: 0.5, start_y: 0.8, end_x: 0.5, end_y: 0.2, duration: 500).perform
    Appium::TouchAction.new.swipe(start_x: 0.5, start_y: 0.8, offset_x: 0.5, offset_y: 0.2, duration: 500).perform
    previous_screen = current_screen
    current_screen = get_source
    arr = find_element(id: "radio_group_to").find_elements(:class, "android.widget.RadioButton")
    arr.each do |v|
      elements.push(v.text)
    end
  end
=begin
  puts ("elements after swipe")
  elements.each do |b|
    puts(b)
  end
=end
  return elements.uniq
end


def conversion()
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
  return result
end