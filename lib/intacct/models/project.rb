module Intacct
  module Models
    class Project < Intacct::Base
      include ::Intacct::Models::Concerns::CustomFieldable

      fields :projectid, :name, :description, :currency, :projectcategory, :projectstatus, :preventtimesheet,
             :preventexpense, :preventappo, :preventgeninvoice, :budgetamount, :contractamount,
             :actualamount, :budgetqty, :percentcomplete, :obspercentcomplete, :customerid, :projecttype,
             :departmentid, :locationid, :managerid, :classid, :docnumber, :billingtype, :ponumber

      field :begindate, dynamic: lambda { |value| value.try(:strftime, '%m/%d/%Y') }
      field :enddate, dynamic: lambda { |value| value.try(:strftime, '%m/%d/%Y') }

      read_only_fields :projectstatuskey, :customerkey, :projecttypekey, :whenmodified

    end
  end
end
