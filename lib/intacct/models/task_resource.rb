module Intacct
  module Models
    class TaskResource < Intacct::Base
      api_name 'TASKRESOURCES'

      field :taskname, :projectid, :employeeid, :budgetqty, :estqty, :description, :isfulltime

      field :pbegindate, dynamic: lambda { |value| value.try(:strftime, '%m/%d/%Y') }
      field :penddate, dynamic: lambda { |value| value.try(:strftime, '%m/%d/%Y') }

    end
  end
end
