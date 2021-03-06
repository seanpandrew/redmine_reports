Feature: Quickbooks Report
  As an Administrator
  I want to see reports on Quickbooks and other financial data
  So I can make financial decisions

  Scenario: See link to the Quickbooks report
    Given I am logged in as an Administrator
    And I am on the system report overview page

    Then I should see "Reports"
    And I should see a link "Quickbooks"

  Scenario: Open link to the Quickbooks report
    Given I am logged in as an Administrator
    And I am on the system report overview page

    When I follow "Quickbooks"

    Then I should be on the "quickbooks" page

  Scenario: See Total PO amounts
    Given I am logged in as an Administrator
    And billing data is in the system
    And I am on the system report quickbooks page

    Then I should see "Total PO"
    And I should see the "Total PO" total
    And I should see the "Total PO" subtotals

  Scenario: See Unspent Labor amounts
    Given I am logged in as an Administrator
    And billing data is in the system
    And I am on the system report quickbooks page

    Then I should see "Unspent Labor"
    And I should see the "Unspent Labor" total
    And I should see the "Unspent Labor" subtotals

  Scenario: See Unbilled Labor amounts
    Given I am logged in as an Administrator
    And billing data is in the system
    And I am on the system report quickbooks page

    Then I should see "Unbilled Labor"
    And I should see the "Unbilled Labor" total
    And I should see the "Unbilled Labor" subtotals

  Scenario: Run Quickbooks Report as normal user
    Given I am logged in as a User
    When I visit the "quickbooks" page
    Then I should be denied access

  Scenario: Run Quickbooks Report as an anonymous user
    Given I am not logged in
    When I visit the "quickbooks" page
    Then I should go to the login page

