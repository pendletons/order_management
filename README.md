# README

This exercise was done using Ruby 2.3.0, Rails 4.2.5, and RSpec 3.4.2.

*N.B. I left the commit history as-is (including stupid typos/retrospective mistake-fixing), ordinarily I'd rebase/squash/etc to clean it up a bit in a real application. I also tried to make it obvious that I did this with a TDD approach via the commit history - again, normally I'd just commit the working version post-TDD.*

### Assumptions

  - VAT would only be changed for future orders, and existing orders would need to maintain their VAT amount at the time
  - All prices should be stored/returned in pence to avoid fractional amounts

### Future Improvements

(Given more time)

  - Localise/translate the error messages
  - Clean up the test suite (DRY it up a bit)
  - More exhaustively test the order states (currently only tested via Cucumber)
  - Return order net/gross amounts as Money?
  - Would be fun to implement the API using Rails 5's new stuff
