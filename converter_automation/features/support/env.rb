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

  width = (find_element(class: "android.widget.ImageButton").rect.width) / 2
  height = ((find_element(class: "android.widget.ImageButton").rect.height) / 2)

  action = Appium::TouchAction.new.press(x: "#{width}", y: "#{height}").wait(5).release
  action.perform

  current_screen = get_source
  previous_screen = ""

  until (exists {find_element(id: "design_navigation_view").find_element(xpath: "//android.widget.CheckedTextView[@text='#{value}']")}) || (previous_screen == current_screen) do

    x1 = (0.1 * find_element(id: "design_navigation_view").rect.width).round
    x2 = x1
    y1 = (0.8 * find_element(id: "design_navigation_view").rect.height).round
    y2 = (0.2 * find_element(id: "design_navigation_view").rect.height).round
    action = Appium::TouchAction.new.swipe(start_x: "#{x1}", start_y: "#{y1}", offset_x: "#{x2}", offset_y: "#{y2}", duration: 500)
    action.perform
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
    Appium::TouchAction.new.swipe(start_x: 0.5, start_y: 0.9, offset_x: 0.5, offset_y: 0.5, duration: 500).perform
    # puts("I'm swiping down")
    previous_screen = current_screen
    current_screen = get_source
  end

  if exists {find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{elem}']")}
    find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{elem}']").click
    result = true
  else
    result = false
    puts("Element wasn't found after swiping down. It's needed to swipe up.")
  end
  return result
end

def swipe_up(elem)
  current_screen = get_source
  previous_screen = ""

  until (exists {find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{elem}']")}) || (previous_screen == current_screen) do
    Appium::TouchAction.new.swipe(start_x: 0.5, start_y: 0.5, offset_x: 0.5, offset_y: 0.9, duration: 500).perform
#    puts("I'm swiping up")
    previous_screen = current_screen
    current_screen = get_source
  end

  if exists {find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{elem}']")}
    find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{elem}']").click
    result = true
  else
    result = false
    puts("Element wasn't found after swiping up. It's needed to swipe down.")
  end
  return result
end


def select_radio_button(elem)
  value_down = swipe_down(elem)

  if !(value_down)
    value_up = swipe_up(elem)
  else
    if value_up == false
      raise ("Element wasn't found in right column!")
    end
  end
  #assert that we checked exact elem radio button in right column
  if find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{elem}']").attribute("checked") != "true"
    raise("#{elem} wasn't checked!")
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

  until (exists {find_element(id: "radio_group_to")
                     .find_element(xpath: "//android.widget.RadioButton[@text='Acre']")}) || (previous_screen == current_screen) do

    Appium::TouchAction.new.swipe(start_x: 0.5, start_y: 0.8, offset_x: 0.5, offset_y: 0.2, duration: 500).perform
    previous_screen = current_screen
    current_screen = get_source
    arr = find_element(id: "radio_group_to").find_elements(:class, "android.widget.RadioButton")
    arr.each do |v|
      elements.push(v.text)
    end
  end

  return elements.uniq
end


def conversion(elem_value)
  if find_element(id: "header_value_to").text == ""
    raise("There is no results after conversions!")
  end
  value_to = (find_element(id: "header_value_to").text).to_f

  if value_to != elem_value
    raise("Conversion result is wrong!")
  end
end
