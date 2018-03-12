@conversion
Feature: User is able verify conversion results

  Background:
    Given I click on Got it button
    And I ground on Area screen
    And I see checked "Sq Kilometre" radio button in From column
    And I see "1.0" in the From text field

  @wip
  Scenario Outline:
    When I see "Sq Metre" default checked in To column
    And I see "1000000" in header_value_to field
    Then I select "<target>" radio button in To column
    And I see "<result>" in header_value_to field

    Examples:
      | target        | result      |
      | Sq Centimetre | 10000000000 |
      | Hectare       | 100         |
      | Acre          | 247.1054    |
