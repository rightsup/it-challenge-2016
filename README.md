# Run with docker

Run a "test" container with:
`docker-compose -f docker-compose.test.yml run sut bash`

Once inside of it, run `bundle exec rake test`.

# Challenge

With this challenge, we're testing your ability to 
- work with Docker and ruby
- write production code with style
- write tests
- understanding a problem

## Overview

We'll be implementing a simplified version of our money distribution system.

A right holder (ie. a client) signs an agreement with RightsUp to collect rights on his behalve. RightsUp will take 20% commission on the revenues.

Therefore, if we receive 100€ for a given recording that is owned by this client, we should keep 20€ to RightsUp and give back 80€ to the right holder.

That's the case if the right holder owns 100% of the right on this recording, but it could also have licensed his rights with somebody else, or the recording may be the result of a co-production with multiple master owners.
Lets say for example that a recording's rights is shared between two of our clients, lets say 50/50, each client should receive 40€ and RightsUp should get 10€ twice.

So we can see this problem as having a list of agreement associated to a recording, simplified with the following value objects: 

```ruby
recording_aggreements = [
  LicenseAgreement.new(
    right_holder_slug: 'stillvortalent',
    owned_percentage: 0.50,
    rightsup_commission: 0.20
  ),
  LicenseAgreement.new(
    right_holder_slug: 'suol',
    owned_percentage: 0.50,
    rightsup_commission: 0.20
  )
]
```

And a row containing revenues for that recording coming from a country.

```ruby
# a CSV line containing some details about the revenues
# that we associated with one of our recording.
DistributionRow.new(amount: 100, recording_id: 12345, ...)
```

## Part 1 - distribute revenues

There are three tests with different level of complexity. The first one in `test/services/compute_distribution/test_simple_case` should be trivial to solve. 

Inside `test/services/compute_distribution/test_split.rb` you have more complex example. The first test is exactly the situation explained above. The second one introduce the notion of "business introducer", where another party has brough to us the deal with the client and get a percentage of our commission. In the example, the "introducer" should get 50% of RightsUp commission.
This example is better explained by the picture at the root of the repository: `distribution_chart.png`.

The output of this method should be an array of `StatementRow` (because from this one row of revenue, we might split into multiple clients). 
(Context: These statement rows could then be used to compute the Statement of the client and create a boundary between the incomming and outgoing revenues).

Your role is to implement the ComputeDistribution method called `distribute_row`.

## Part 2 - invariants

We would like to be always sure that we don't distribute more than what we're receiving. Can you test and implement such logic ?
There is a blank test file for that at `test/services/compute_distribution/test_invariant.rb`.

## Part 3 - improvements / open questions

- From a business concern point of view, what are we missing to have a "production-ready" implementation?
- If we want to connect this service to the rest of our system, what would be the events (event name + payload schema) that this service would emit on the bus ?
- ...


