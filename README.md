## Overview

The program uses the http://level-labs.com API [documented here](https://doc.level-labs.com) to provide basic reporting.

The initial version accepts a single user for reporting.

### Usage

> `bin/levelmoney [command]

Step 1: Setup credentials by running the following:

> `bin/levelmoney credentials

Step 2: Do some amazing reporting!

> `bin/levelmoney report 

### Monthly Reporting ###

Report how much money the user spends and makes in each of the months for which we have data.

Assumption: is that it is for that User and there might be gap months or no data at all.)

Report format in the standard form is:
  > `{
  >  "2014-10": {"spent": "$200.00", "income": "$500.00"},
  >  "2014-11": {"spent": "$1510.05", "income": "$1000.00"},
  >  "2015-04": {"spent": "$300.00", "income": "$500.00"},
  >  "average": {"spent": "$750.00", "income": "$950.00"}
  > }`

Feature Possibility:  Add a more pretty format, if you see fit.

### "Average" Reporting Defined

Report the "average" month. The average is currently the total / count for the monthly report.
### Extra Features ###

We’d also like you to try and add at least one “additional feature” to this program (and if you’re able, all of them).

They’re listed below as command line switches for a terminal program, but we’d accept any method that lets a user decide how to display this data.

#### --ignore-donuts
The user is so enthusiastic about donuts that they don't want donut spending to come out of their budget. Disregard all donut-related transactions from the spending. You can just use the merchant field to determine what's a donut - donut transactions will be named “Krispy Kreme Donuts” or “DUNKIN #336784”.

#### --crystal-ball ###

 We expose a GetProjectedTransactionsForMonth endpoint, which returns all the transactions that have happened or are expected to happen for a given month. It looks like right now it only works for this month, but that's OK. Merge the results of this API call with the full list from GetAllTransactions and use it to generate predicted spending and income numbers for the rest of this month, in addition to previous months.

#### --ignore-cc-payments ###

Paying off a credit card shows up as a credit transaction and a debit transaction, but it's not really "spending" or "income". Make your aggregate numbers disregard credit card payments.

For the users we give you, credit card payments will consist of two transactions with opposite amounts (e.g. 5000000 centocents and -5000000 centocents) within 24 hours of each other. For verification, you should also output a list of the credit card payments you detected - this can be in whatever format you like.
