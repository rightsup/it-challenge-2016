# Run with docker

Run a "test" container with:
`docker-compose -f docker-compose.test.yml run sut bash`

Once inside of it, run `bundle exec rake test`.