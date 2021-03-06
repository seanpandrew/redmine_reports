if Redmine::Plugin.registered_plugins.keys.include? :redmine_billing

  module Reports
    module Quickbooks
      def quickbooks
        @total_po = []
        Project.find(:all).collect do |project|
          @total_po << [project.name, project.total_value] unless project.total_value.nil?
        end

        # Sort by name
        @total_po.sort! do |a,b|
          a[0] <=> b[0]
        end
        @total_po_total = @total_po.collect {|po_item| po_item[1].to_f}.sum
        
        @unspent_labor = BillingExport.unspent_labor
        @unspent_labor_total = @unspent_labor.collect {|labor| labor[1].to_f}.sum

        @unbilled_labor = BillingExport.unbilled_labor
        @unbilled_labor_total = @unbilled_labor.collect {|labor| labor[1].to_f}.sum
      end
    end
  end

  # Added the report and configure it's permissions
  require 'dispatcher'
  Dispatcher.to_prepare do
    SystemReportsController.add_report(:quickbooks, Reports::Quickbooks, {:action => :quickbooks, :label => :reports_quickbooks})
    SystemReportsController.require_admin(:quickbooks)
  end
else
  Rails.logger.info("*** redmine_reports: Redmine billing plugin not installed, Quickbooks report unavailable")
end
