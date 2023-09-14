require "spec_helper"

describe Intacct::Base do
  module Intacct
    module Models
      class Example < Intacct::Base
      end
    end
  end

  let(:client)  { double("client") }
  let(:attrs)   { {} }

  subject { Intacct::Models::Example.new(client, attrs) }

  it "builds an Example model" do
    example = Intacct::Models::Example.build(client, id: "12345")

    expect(example.client).to eq(client)
    expect(example.id).to eq "12345"
  end

  context "when errors are present" do
    let(:errors) { [{ "description" => "first desc", "description2" => "second desc" }] }

    it "formats the error correctly" do
      example = Intacct::Models::Example.formatted_error_message(errors)

      expect(example).to eq("first desc: second desc")
    end

    context "when description or desciption2 is not present" do
      let(:errors) { [{ "description2" => "second desc" }] }

      it "formats the error correctly" do
        example = Intacct::Models::Example.formatted_error_message(errors)

        expect(example).to eq("second desc")
      end
    end

    context "when description and desciption2 is not present" do
      let(:errors) { [{}] }

      it "formats the error correctly" do
        example = Intacct::Models::Example.formatted_error_message(errors)

        expect(example).to eq("Undefined error")
      end
    end
  end
end
