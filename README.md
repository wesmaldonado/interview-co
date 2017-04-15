### Monthly Reporting ###

Report how much money the user spends and makes in each of the months for which we have data.

Assumption: is that it is for that User and there might be gap months or no data at all.)

### Summary Reporting ###

Report the "average" month. Note: Definition of "average" is defined by software and needs to be explained.
Report format in the standard form is:
  > `{
  >  "2014-10": {"spent": "$200.00", "income": "$500.00"},
  >  "2014-11": {"spent": "$1510.05", "income": "$1000.00"},
  >  "2015-04": {"spent": "$300.00", "income": "$500.00"},
  >  "average": {"spent": "$750.00", "income": "$950.00"}
  > }`

Feature Possibility:  Add a more pretty format, if you see fit.

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

====

Yon, James <James.Yon@capitalone.com>	Fri, Apr 14, 2017 at 3:52 PM
To: "wesleym@gmail.com" <wesleym@gmail.com>
Hi Wes,



Thanks for the resume.  Let’s move forward on and Engineering opportunity if you are interested? As the next step in our process we’d like you to do a coding exercise.  Instructions are below.  You can code in any programming language you’d like.  Please send us your completed exercise by early next week if possible.



Coding Exercise Instructions:

Our API is documented at https://doc.level-labs.com - username: interview@levelmoney.com password: password2. We'd like you to write a program that:
·         Loads a user's transactions from the GetAllTransactions endpoint
·         Determines how much money the user spends and makes in each of the months for which we have data, and in the "average" month. What "average" means is up to you.
·         Output these numbers in the following format (and optionally in a more pretty format, if you see fit)
{"2014-10": {"spent": "$200.00", "income": "$500.00"},
"2014-11": {"spent": "$1510.05", "income": "$1000.00"},
...
"2015-04": {"spent": "$300.00", "income": "$500.00"},
"average": {"spent": "$750.00", "income": "$950.00"}}
You have considerable latitude on how to display this data, obtain it, and what language to use. Please do this in the way that feels most comfortable for you. For many of our applicants, they prefer to use a script you run from the command line. For some, it is a webpage that displays things. For others, it’s a live code notebook. What’s important is that it is reproducible by us.
We’d also like you to try and add at least one “additional feature” to this program (and if you’re able, all of them). They’re listed below as command line switches for a terminal program, but we’d accept any method that lets a user decide how to display this data.
·         --ignore-donuts: The user is so enthusiastic about donuts that they don't want donut spending to come out of their budget. Disregard all donut-related transactions from the spending. You can just use the merchant field to determine what's a donut - donut transactions will be named “Krispy Kreme Donuts” or “DUNKIN #336784”.
·         --crystal-ball: We expose a GetProjectedTransactionsForMonth endpoint, which returns all the transactions that have happened or are expected to happen for a given month. It looks like right now it only works for this month, but that's OK. Merge the results of this API call with the full list from GetAllTransactions and use it to generate predicted spending and income numbers for the rest of this month, in addition to previous months.
·         --ignore-cc-payments: Paying off a credit card shows up as a credit transaction and a debit transaction, but it's not really "spending" or "income". Make your aggregate numbers disregard credit card payments. For the users we give you, credit card payments will consist of two transactions with opposite amounts (e.g. 5000000 centocents and -5000000 centocents) within 24 hours of each other. For verification, you should also output a list of the credit card payments you detected - this can be in whatever format you like.

We recommend using Github for source control and checking-in often as you work (even if this means the that not every ref in the branch you work on compiles). This gives us some insight into how you work, without us having to look over your shoulder every 5 minutes.



When you have completed the exercise, please upload your entire solution to Github.com if your code is not already there.  Then send an email with the URL of your repository to COFI_Coding_Exercise@capitalone.com  Please make sure you have an appropriate README documenting how we should compile (if necessary) and run your solution.



Thanks again,

James Yon
Recruiting Manager
Retail & Direct Technology
415.238.0745
id:image003.png@01CF9C43.69A16340  acebook logoid:image006.jpg@01CF9C43.69A16340id:image007.jpg@01CF9C43.69A16340id:image008.jpg@01CF9C43.69A16340
ttps://tm-prod.global.ssl.fastly.net/etc/email-signature-blue.png
