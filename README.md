# Simple Logger

> I am a simple man, I like simple loggers - Me

Request logger for [Amber Framework](https://github.com/amberframework/amber)

* Easier to parse, ideal for log aggregators
* Add an UUID to each request
* Smaller logs

From this:

```
01:37:43 Request    | Started 2018-05-06 13:37:43 +02:00
01:37:43 Request    | Status: 200  Method: GET  Pipeline: web Format: html
01:37:43 Request    | Requested Url: /
01:37:43 Request    | Time Elapsed: 263.0µs
01:37:43 Headers    | Host: ["localhost:3000"]
01:37:43 Headers    | User-Agent: ["Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:59.0) Gecko/20100101 Firefox/59.0"]
01:37:43 Headers    | Accept: ["text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"]
01:37:43 Headers    | Accept-Language: ["en-US,en;q=0.5"]
01:37:43 Headers    | Accept-Encoding: ["gzip, deflate"]
01:37:43 Headers    | Cookie: ["amber.session=eyJfZmxhc2giOiJ7fSJ9--EopkYJ%2B7PiP81%2Fp9tb9OUUyRor8%3D"]
01:37:43 Headers    | DNT: ["1"]
01:37:43 Headers    | Connection: ["keep-alive"]
01:37:43 Headers    | Upgrade-Insecure-Requests: ["1"]
01:37:43 Headers    | Cache-Control: ["max-age=0"]
01:37:43 Cookies    | amber.session: #<HTTP::Cookie:0x557fa0243840>
01:37:43 Session    | _flash: {}
```

To this:

```
01:34:21 ae729e96-22f1-480e-a4b1-ca2b94f3abf4 | (INFO)  method=GET path=/ format=html pipeline=web controller=HomeController action=index status=200 duration=350.0µs
```

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  simplelogger:
    github: epergo/simplelogger
```

## Usage

Require in you `application.cr` file:

```crystal
require "simplelogger"
```

Add it to your pipeline:


```crystal
pipeline :web do
  . . .

  plug SimpleLogger.new

  . . .
end
```

Or use it only in production environment:

```crystal
pipeline :web do
  . . .

  plug Amber.env.production? ? SimpleLogger.new : Amber::Pipe::Logger.new

  . . .
end
```

## Contributing

1. Fork it ( https://github.com/epergo/simplelogger/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
