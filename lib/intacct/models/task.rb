module Intacct
  module Models
    class Task < Intacct::Base
      include ::Intacct::Models::Concerns::CustomFieldable

      fields :name, :description, :projectid, :itemid, :billable, :taxdescription, :ismilestone, :utilized,
             :priority, :taskno, :taskstatus, :parentkey, :budgetqty, :estqty

      field :pbegindate, dynamic: lambda { |value| value.try(:strftime, '%m/%d/%Y') }
      field :penddate, dynamic: lambda { |value| value.try(:strftime, '%m/%d/%Y') }

    end
  end
end
