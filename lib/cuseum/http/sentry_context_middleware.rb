module Cuseum
  module Http
    class SentryContextMiddleware < Faraday::Middleware
      def call(request_env)
        Raven.breadcrumbs.record do |crumb|
          crumb.data = {
            request_env: serialize_env(request_env, :request_headers)
          }
          crumb.category = 'faraday'
          crumb.timestamp = Time.now.to_i
          crumb.message = "Started request to #{request_env[:url]}"
        end

        @app.call(request_env).on_complete do |response_env|
          Raven.breadcrumbs.record do |crumb|
            crumb.data = {
              response_env: serialize_env(response_env, :response_headers)
            }
            crumb.category = 'faraday'
            crumb.timestamp = Time.now.to_i
            crumb.message = "Completed request to #{request_env[:url]}"
          end

          if response_env.status == 400
            Raven.capture_exception(Faraday::ClientError.new(nil, response_env))
          end
        end
      end

      def serialize_env(env, headers_key)
        {
          method:  env.method,
          body:    env.body,
          headers: env[headers_key],
          status:  env.status
        }
      end
    end
  end
end
