# SpotTheStation

Calendar with events of ISS flyovers. Subscribe to it with your Mac OS Calendar App or any other iCalendar subscription compatible software.

Pass in the params used at Nasa's [Spot the Station](https://spotthestation.nasa.gov) Search Form to this URL [https://localhost:4000/for_city](https://localhost:4000/for_city).

For Cologne in Germany this would be [https://localhost:4000/for_city?country=Germany&region=None&city=Cologne]

The .ics file is available at [https://localhost:4000/cologne.ics](https://localhost:4000/cologne.ics)

Uses Nasa's [Spot the Station](c) RSS Feed.


##

Deployed to [spotthestation.ede.li](spotthestation.ede.li)

## Development

### Next Todos:
* test mime type in page_controller_test


To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
