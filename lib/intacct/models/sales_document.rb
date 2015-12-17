module Intacct
  module Models
    class SalesDocument < Base
      include ::Intacct::Models::Concerns::CustomFieldable
      include ::Intacct::Support::Sublist

      api_name 'sodocument'

      fields :transactiontype, :createdfrom, :customerid

      field :datecreated, dynamic: lambda { |value| value.try(:strftime, '%m/%d/%Y') }
      field :dateposted, dynamic: lambda { |value| value.try(:strftime, '%m/%d/%Y') }

      field :sodocumententries, class: SalesDocumentEntry,
                                list:  true

    end
  end
end
