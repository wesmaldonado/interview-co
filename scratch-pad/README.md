# Approach

I have 2 hours today to explore and get the bulk of the work done before Easter activities start.
Sunday is spent driving so I need to capture enough detail to work offline in the car.

## Exploration

When exploring a new API I use the command line quite a bit.
I tend to make small ruby snippets or shell scripts to get different output
until I have confidence to move into a more formal TDD harness.

### get all transactions #

Ran the docs curl command, prettied it up with jq.
> `sh get_all_transactions.sh > get_all_transactions.output`
> `jq . get_all_transactions.output > get_all_transactions.pretty``

At this point I see the shape of the results and know my next step 
is likely to make sure I have the data needed in this result for the
core requirements.

- [x] Can I get dates from the timestamps?
- [x] Are all the responses of the same shape? I noticed some have extra fields like payee-for-testing and similar. The example code shows me how for a few languages..
- [x] Is there sample code? Yup.
- [x] Is the sample code or client usable? Code is ok and seems to work, probably rip from it for getting thet type info.
- [ ] How can I make sure it is runnable by them?


