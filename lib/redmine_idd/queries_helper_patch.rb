module RedmineIdd
  module QueriesHelperPatch
    def self.included(base)
      base.class_eval do
        def column_value(column, issue, value)
          case column.name
            when :id
              link_to value, issue_path(issue)
            when :subject
              link_to value, issue_path(issue)
            when :parent
              value ? (value.visible? ? link_to_issue(value, :subject => false) : "##{value.id}") : ''
            when :description
              issue.description? ? content_tag('div', textilizable(issue, :description), :class => "wiki") : ''
            when :done_ratio
              progress_bar(value)
            when :relations
              content_tag('span',
                          value.to_s(issue) {|other| link_to_issue(other, :subject => false, :tracker => false)}.html_safe,
                          :class => value.css_classes_for(issue))
            else
              case value.class.name
                when 'Time'
                  if ( column.name == :start_date or column.name == :due_date ) and
                      ( !issue.project.use_datetime_for_issues or value.strftime('%H%M')=='0000' )
                    format_date(value)
                  else
                    format_time(value)
                  end
                else
                  format_object(value)
              end
          end
        end
      end
    end
  end
end
