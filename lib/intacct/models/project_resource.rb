module Intacct
  module Models
    class ProjectResource < Intacct::Base

      api_name 'projectresources'

      fields :projectid, :employeeid, :itemid, :billingrate, :description

    end
  end
end
