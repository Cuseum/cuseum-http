require 'spec_helper'

describe Cuseum::Http::Client do
  describe '#post' do
    let(:payload) { {} }

    subject { described_class.new.post('https://example.com', body: payload) }

    before do
      stub_request(:post, 'https://example.com/')
        .to_return(status: status, body: response.to_json)
    end

    context 'when response is valid' do
      let(:status) { 200 }
      let(:payload) { { foo: 'bar' } }
      let(:response) { {} }

      it 'sends a request' do
        subject

        expect(WebMock)
          .to have_requested(:post, 'https://example.com')
          .with(body: '{"foo":"bar"}')
      end

      it 'does not raise exception' do
        expect { subject }.to_not raise_exception
      end
    end
  end

  describe '#put' do
    let(:payload) { {} }

    subject { described_class.new.put('https://example.com', body: payload) }

    before do
      stub_request(:put, 'https://example.com/')
        .to_return(status: status, body: response.to_json)
    end

    context 'when response is valid' do
      let(:status) { 200 }
      let(:payload) { { foo: 'bar' } }
      let(:response) { {} }

      it 'sends a request' do
        subject

        expect(WebMock)
          .to have_requested(:put, 'https://example.com')
          .with(body: '{"foo":"bar"}')
      end

      it 'does not raise exception' do
        expect { subject }.to_not raise_exception
      end
    end
  end

  describe '#head' do
    let(:payload) { {} }

    subject { described_class.new.head('https://example.com', body: payload) }

    before do
      stub_request(:head, 'https://example.com/?foo=bar')
        .to_return(status: status, body: response.to_json)
    end

    context 'when response is valid' do
      let(:status) { 200 }
      let(:payload) { { foo: 'bar' } }
      let(:response) { {} }

      it 'sends a request' do
        subject

        expect(WebMock)
          .to have_requested(:head, 'https://example.com?foo=bar')
      end

      it 'does not raise exception' do
        expect { subject }.to_not raise_exception
      end
    end
  end

  describe '#get' do
    let(:payload) { {} }

    subject { described_class.new.get('https://example.com', body: payload) }

    before do
      stub_request(:get, 'https://example.com/?foo=bar')
        .to_return(status: status, body: response.to_json)
    end

    context 'when response is valid' do
      let(:status) { 200 }
      let(:payload) { { foo: 'bar' } }
      let(:response) { {} }

      it 'sends a request' do
        subject

        expect(WebMock)
          .to have_requested(:get, 'https://example.com?foo=bar')
      end

      it 'does not raise exception' do
        expect { subject }.to_not raise_exception
      end
    end
  end
end
