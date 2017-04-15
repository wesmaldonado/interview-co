When exploring a new API I use the command line quite a bit.
I tend to make small ruby snippets or shell scripts to get different output
until I have confidence to move into a more formal TDD harness.

# get all transactions #

Ran the docs curl command, prettied it up with jq.
> `sh get_all_transactions.sh > get_all_transactions.output`
> `jq . get_all_transactions.output > get_all_transactions.pretty``

At this point I see the shape of the results and know my next step 
is likely to make sure I have the data needed in this result for the
core requirements.

Can I get dates from the timestamps?
Do I know the types of the fields?
Are all the responses of the same shape? I noticed some have extra fields like payee-for-testing and similar..

