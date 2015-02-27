Feature: Accept Coins
As a vendor
I want a vending machine that accepts coins
So that I can collect money from the customer

#declarative
Scenario: Accept valid coin
When a valid coin is entered
Then the coin is accepted

Scenario: Accept valid coin with no coins inserted
Given there are no coins inserted
  And the machine displays no coins are inserted
When a valid coin is entered
Then the coin is accepted

Scenario: Reject invalid coin
When an invalid coin is entered
Then the coin is rejected

Scenario: Reject invalid coin with no coins inserted
Given there are no coins inserted
  And the machine displays no coins are inserted
When an invalid coin is entered
Then the coin is rejected

#imparative
Scenario Outline: Accept valid coin
When a <valid_coin> is entered
Then the coin is <status>

Examples:
| valid_coin | status |
| nickle | accepted |
| dime | accepted |
| quarter | accepted |


Scenario Outline: Accept valid coin with no coins inserted
Given there are <current_state> inserted
And the machine displays <message>
When a <valid_coin> is entered
Then the coin is <status>

Examples:
| current_amount | message | valid_coin | status |
| 0 | "INSERT COIN" | nickle | accepted |
| 0 | "INSERT COIN" | dime | accepted |
| 0 | "INSERT COIN" | quarter | accepted |

Scenario Outline: Reject valid coin
When a <invalid_coin> is entered
Then the coin is <status>

Examples:
| invalid_coin | status |
| wheat_penny | rejected |
| chocolate_quarter | rejected |
| scrap_metal | rejected |

Scenario Outline: Reject invalid coin with no coins inserted
Given there are <current_state> inserted
And the machine displays <message>
When a <invalid_coin> is entered
Then the coin is <status>

Examples:
| current_amount | message | invalid_coin | status |
| 0 | "INSERT COIN" | wheat_penny | rejected |
| 0 | "INSERT COIN" | chocolate_quarter | rejected |
| 0 | "INSERT COIN" | scrap_metal | rejected |

#imparative cumulative
Scenario Outline: check validity of coin
Given there are <current_state> inserted
And the machine displays <message>
When a <coin> is entered
Then the coin is <status>

Examples:
| current_amount | message | coin | status |
| 0 | "INSERT COIN" | wheat_penny | rejected |
| 0 | "INSERT COIN" | chocolate_quarter | rejected |
| 0 | "INSERT COIN" | scrap_metal | rejected |
| 0 | "INSERT COIN" | penny | rejected |
| 0 | "INSERT COIN" | nickle | accepted |
| 0 | "INSERT COIN" | dime | accepted |
| 0 | "INSERT COIN" | quarter | accepted |

Scenario Outline: check validity of coin and register value
Given there are <current_state> inserted
And the machine displays <message>
When a <coin> is entered
Then the coin is <status>
And the <coin_value> is calculated
And the new message is <new_message>

Examples:
| current_amount | message | coin | status | coin_value | new_message |
| 0 | "INSERT COIN" | wheat_penny | rejected | 0 | "INSERT COIN" |
| 0 | "INSERT COIN" | chocolate_quarter | rejected | 0 | "INSERT COIN" |
| 0 | "INSERT COIN" | scrap_metal | rejected | 0 | "INSERT COIN" |
| 0 | "INSERT COIN" | penny | rejected | 0 | "INSERT COIN" |
| 0 | "INSERT COIN" | nickle | accepted | .05 | "$0.05" |
| 0 | "INSERT COIN" | dime | accepted | .10 | "$0.10" |
| 0 | "INSERT COIN" | quarter | accepted | .25 | "$0.25" |
| .25 | "$0.25" | quarter | accepted | .25 | "$0.50" |
| 1.05 | "$1.05" | dime | accepted | .10 | "$1.15" |
| .55 | "$0.55" | penny | rejected | 0 | "$0.55" |
