module Intacct
  module Models
    class Department < Base

      fields :departmentid, :title, :parentid, :supervisorid, :supervisorname, :status, :custtitle

      read_only_fields :whenmodified

    end
  end
end
