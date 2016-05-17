module RedmineIdd
module ApplicationHelperPatch
  def self.included(base)
    base.class_eval do
      def calendar_for_issue(field_id)
        include_calendar_headers_tags
        javascript_tag("$(function() { $('##{field_id}').addClass('date').datetimepicker(datepickerOptions); });")
      end
    end
  end
end

end