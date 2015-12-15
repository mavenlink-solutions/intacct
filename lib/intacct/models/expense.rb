module Intacct
  module Models
    class Expense < Base
      include ::Intacct::Models::Concerns::CustomFieldable

      fields :expensetype, :amount, :memo, :locationid, :departmentid, :glaccountno, :currency, :trx_amount,
             :exchratetype, :exchrate, :projectid, :customerid, :vendorid, :employeeid, :itemid, :classid

      field :expensedate, dynamic: lambda { |value| value.try(:strftime, '%m/%d/%Y') }
      field :exchratedate, dynamic: lambda { |value| value.try(:strftime, '%m/%d/%Y') }

    end
  end
end
