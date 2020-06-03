module Cuseum
  module Http
    class Client
      extend T::Sig

      sig { params(url: String, body: Hash, headers: Hash).returns(Faraday::Response) }
      def post(url, body: {}, headers: {})
        send_request(:post, url, body: body, headers: headers)
      end

      sig { params(url: String, body: Hash, headers: Hash).returns(Faraday::Response) }
      def put(url, body: {}, headers: {})
        send_request(:put, url, body: body, headers: headers)
      end

      sig { params(url: String, body: Hash, headers: Hash).returns(Faraday::Response) }
      def head(url, body: {}, headers: {})
        send_request(:head, url, body: body, headers: headers)
      end

      sig { params(url: String, body: Hash, headers: Hash).returns(Faraday::Response) }
      def get(url, body: {}, headers: {})
        send_request(:get, url, body: body, headers: headers)
      end

      private

      sig { params(method: Symbol, url: String, body: Hash, headers: Hash).returns(Faraday::Response) }
      def send_request(method, url, body: {}, headers: {})
        client.public_send(method, url, body, headers.transform_values(&:to_s))
      end

      sig { returns(Faraday::Connection) }
      def client
        @client ||= Faraday.new do |conn|
          conn.request :retry
          conn.request :json
          conn.request :url_encoded

          conn.response :json, content_type: /\bjson$/

          conn.use Cuseum::Http::SentryContextMiddleware

          conn.adapter Faraday.default_adapter
        end
      end
    end
  end
end
