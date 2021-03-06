$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'base64'
require 'multi_json'

require 'metrics/client'
require 'metrics/collection'
require 'metrics/connection'
require 'metrics/errors'
require 'metrics/persistence'
require 'metrics/queue'
require 'metrics/version'

module Librato

  # Metrics provides a simple wrapper for the Metrics web API with a
  # number of added conveniences for common use cases.
  #
  # See the {file:README.md README} for more information and examples.
  #
  # @example Simple use case
  #   Librato::Metrics.authenticate 'email', 'api_key'
  #
  #   # list current metrics
  #   Librato::Metrics.list
  #
  #   # submit a metric immediately
  #   Librato::Metrics.submit :foo => 12712
  #
  #   # fetch the last 10 values of foo
  #   Librato::Metrics.fetch :foo, :count => 10
  #
  # @example Queuing metrics for submission
  #   queue = Librato::Metrics::Queue.new
  #
  #   # queue some metrics
  #   queue.add :foo => 12312
  #   queue.add :bar => 45678
  #
  #   # send the metrics
  #   queue.submit
  #
  # @example Using a Client object
  #   client = Librato::Metrics::Client.new
  #   client.authenticate 'email', 'api_key'
  #
  #   # list client's metrics
  #   client.list
  #
  #   # create an associated queue
  #   queue = client.new_queue
  #
  #   # queue up some metrics and submit
  #   queue.add :foo => 12345
  #   queue.add :bar => 45678
  #   queue.submit
  #
  # @note Most of the methods you can call directly on Librato::Metrics are
  #   delegated to {Client} and are documented there.
  module Metrics
    extend SingleForwardable

    TYPES = [:counter, :gauge]

    # Expose class methods of Simple via Metrics itself.
    #
    def_delegators :client, :agent_identifier, :api_endpoint,
                   :api_endpoint=, :authenticate, :connection, :fetch,
                   :list, :persistence, :persistence=, :persister, :submit

    # The Librato::Metrics::Client being used by module-level
    # access.
    #
    # @return [Client]
    def self.client
      @client ||= Librato::Metrics::Client.new
    end

  end
end
