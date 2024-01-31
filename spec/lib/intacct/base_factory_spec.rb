require "spec_helper"

describe Intacct::BaseFactory do
  module Intacct
    module Models
      class Foo
      end
    end
  end

  let(:client) { double }
  let(:klass)  { "Foo" }
  subject      { Intacct::BaseFactory.new(client, klass) }

  it "initializes correctly" do
    expect(subject.client).to       eq(client)
    expect(subject.target_class).to eq(Intacct::Models::Foo)
  end

  it "proxies get to the target class" do
    allow(Intacct::Models::Foo).to receive(:get)
    subject.get("1")
    expect(Intacct::Models::Foo).to have_received(:get) do |*args, **_kwargs|
      expect(args).to eq([client, "1"])
    end
  end

  it "proxies read_by_query to the target class" do
    allow(Intacct::Models::Foo).to receive(:read_by_query)
    subject.read_by_query(query: "FOO")
    expect(Intacct::Models::Foo).to have_received(:read_by_query) do |*args, **kwargs|
      expect(args).to eq([client])
      expect(kwargs).to eq({ query: "FOO" })
    end
  end

  it "returns the target class" do
    expect(subject.target_class).to eq(Intacct::Models::Foo)
  end

  it "proxies build to the target class" do
    attrs = double
    allow(Intacct::Models::Foo).to receive(:build)
    subject.build(attrs)
    expect(Intacct::Models::Foo).to have_received(:build) do |*args, **_kwargs|
      expect(args).to eq([client, attrs])
    end
  end
end
