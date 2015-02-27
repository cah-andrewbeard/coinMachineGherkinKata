feature: as a vendor, I want customers to select products, so that I can give them an incentive to put money in the machine

Scenario: Select an item
Given I have entered enough money
When I select an item
Then an item is dispensed
