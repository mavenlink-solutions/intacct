$: << File.expand_path(File.dirname(__FILE__))

require 'net/http'
require 'nokogiri'
require 'hooks'
require 'active_support/all'
require 'intacct/init'
require 'intacct/version'

module Intacct
  extend self

  attr_accessor :xml_sender_id  , :xml_password    ,
                 :user_id        , :company_id      , :password ,
                 :invoice_prefix , :bill_prefix     ,
                 :vendor_prefix  , :customer_prefix ,
                 :project_prefix , :task_prefix

  def configure
    yield self
  end

  autoload :Base,         'intacct/base'
  autoload :BaseFactory,  'intacct/base_factory'
  autoload :Client,       'intacct/client'
  autoload :Callbacks,    'intacct/callbacks'
  autoload :Errors,       'intacct/errors'
  autoload :QueryResult,  'intacct/query_result'
  autoload :Response,     'intacct/response'
  autoload :XmlRequest,   'intacct/xml_request'
  autoload :Utils,        'intacct/utils'

  module Models
    module Concerns
      autoload :CustomFieldable, 'intacct/models/concerns/custom_fieldable'
    end

    autoload :Bill,             'intacct/models/bill'
    autoload :ClassDimension,   'intacct/models/class_dimension'
    autoload :Customer,         'intacct/models/customer'
    autoload :Department,       'intacct/models/department'
    autoload :Employee,         'intacct/models/employee'
    autoload :ExpenseReport,    'intacct/models/expense_report'
    autoload :Expense,          'intacct/models/expense'
    autoload :Invoice,          'intacct/models/invoice'
    autoload :Location,         'intacct/models/location'
    autoload :Project,          'intacct/models/project'
    autoload :ProjectResource,  'intacct/models/project_resource'
    autoload :ProjectStatus,    'intacct/models/project_status'
    autoload :ProjectType,      'intacct/models/project_type'
    autoload :Task,             'intacct/models/task'
    autoload :Task_resource,    'intacct/models/task_resource'
    autoload :Timesheet,        'intacct/models/timesheet'
    autoload :TimesheetEntry,   'intacct/models/timesheet_entry'
    autoload :Vendor,           'intacct/models/vendor'
  end

  module Support
    autoload :Fields,  'intacct/support/fields'
    autoload :XML,     'intacct/support/xml'
    autoload :DSL,     'intacct/support/dsl'
    autoload :Actions, 'intacct/support/actions'
    autoload :Sublist, 'intacct/support/sublist'
  end

  module Actions
    autoload :Base,        'intacct/actions/base'
    autoload :Get,         'intacct/actions/get'
    autoload :Read,        'intacct/actions/read'
    autoload :ReadByQuery, 'intacct/actions/read_by_query'
    autoload :ReadMore,    'intacct/actions/read_more'
    autoload :Create,      'intacct/actions/create'
    autoload :Update,      'intacct/actions/update'
    autoload :UpdateAll,   'intacct/actions/update_all'
    autoload :BulkCreate,  'intacct/actions/bulk_create'
    autoload :Inspect,     'intacct/actions/inspect'
    autoload :Delete,      'intacct/actions/delete'
  end
end
