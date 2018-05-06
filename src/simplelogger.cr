require "amber"

class SimpleLogger < ::Amber::Pipe::Base
  def call(context : HTTP::Server::Context) : HTTP::Server::Context
    elapsed_time = Time.measure { call_next(context) }
    msg = String.build do |str|
      str << "method=#{context.request.method}"
      str << " path=#{context.requested_url}"
      str << " format=#{context.format}"
      str << " pipeline=#{context.valve}"
      str << " controller=#{context.request.route.controller}"
      str << " action=#{context.request.route.action}"
      str << " status=#{context.response.status_code}"
      str << " duration=#{elapsed_text(elapsed_time)}"
    end

    Amber.logger.info(msg, UUID.random.to_s)
    context
  end

  private def elapsed_text(elapsed : Time::Span) : String
    milliseconds = elapsed.total_milliseconds.round(2)
    milliseconds >= 1 ? "#{milliseconds}ms" : "#{milliseconds * 1000}µs"
  end
end
