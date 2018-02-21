require "appium_lib"

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

  current_screen = get_source
  previous_screen = ""

  until (exists {find_element(id: "design_navigation_view").find_element(xpath: "//android.widget.CheckedTextView[@text='#{value}']")}) || (previous_screen == current_screen) do
    Appium::TouchAction.new.swipe(start_x: 0.1, start_y: 0.8, end_x: 0.1, end_y: 0.2, duration: 500).perform
    previous_screen = current_screen
    current_screen = get_source
  end

  if exists {find_element(id: "design_navigation_view").find_element(xpath: "//android.widget.CheckedTextView[@text='#{value}']")}
    find_element(id: "design_navigation_view").find_element(xpath: "//android.widget.CheckedTextView[@text='#{value}']").click
  else
    fail("Element #{value} was not found in menu")
  end
end

def select_radio_button(elem)
  current_screen = get_source
  previous_screen = ""

  until (exists {find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{elem}']")}) || (previous_screen == current_screen) do
    Appium::TouchAction.new.swipe(start_x: 0.5, start_y: 0.8, end_x: 0.5, end_y: 0.2, duration: 500).perform
    previous_screen = current_screen
    current_screen = get_source
  end

  if exists {find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{elem}']")}
    find_element(id: "radio_group_to").find_element(xpath: "//android.widget.RadioButton[@text='#{elem}']").click
  else
    raise("Radio button #{elem} was not found in menu")
  end
end

def convertion()
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