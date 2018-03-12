@groupTo
  Feature: User is able to switch between the group_to radio buttons in the "To" right column

    Background:
      Given I click on Got it button
      And I ground on Area screen
      And I see "1.0" in the From text field

      #@wip
      Scenario:
        Then I see text in To header
        Then I find index checked radio button

