module Intacct
  module Models
    class Timesheet < Intacct::Base
      include ::Intacct::Support::Sublist

      fields :employeeid, :description, :state, :lines

      field :begindate, dynamic: lambda { |value| value.try(:strftime, '%m/%d/%Y') }

      field :timesheetentries, class: TimesheetEntry,
                               list:  true
    end
  end
end
