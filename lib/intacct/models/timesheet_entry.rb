module Intacct
  module Models
    class TimesheetEntry < Base
      include ::Intacct::Models::Concerns::CustomFieldable

      fields :lineno, :projectid, :taskkey, :customerid, :itemid, :qty, :description, :notes, :state,
             :locationid, :departmentid, :timetype, :billable, :vendorid, :classid

      field :entrydate, dynamic: lambda { |value| value.try(:strftime, '%m/%d/%Y') }
    end
  end
end
