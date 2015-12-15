module Intacct
  module Models
    class ExpenseReport < Intacct::Base
      include ::Intacct::Models::Concerns::CustomFieldable
      include ::Intacct::Support::Sublist
      api_name 'EEXPENSES'

      fields :employeeid, :description, :basecurr, :currency

      field :eexpensesitems, class: Expense,
                             list:  true

      read_only_fields :expensereportno, :datecreated, :whenmodified

    end
  end
end
