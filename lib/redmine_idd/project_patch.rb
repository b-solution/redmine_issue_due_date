module RedmineIdd
  module ProjectPatch
    def self.included(base)
      base.class_eval do
        safe_attributes 'use_datetime_for_issues'
        def start_date
          @start_date ||= [
              issues.minimum('start_date').nil? ? nil : issues.minimum('start_date').to_date,
              shared_versions.minimum('effective_date'),
              Issue.fixed_version(shared_versions).minimum('start_date').nil? ? nil : Issue.fixed_version(shared_versions).minimum('start_date').to_date
          ].compact.min
        end

# The latest due date of an issue or version
        def due_date
          @due_date ||= [
              issues.maximum('due_date').nil? ? nil : issues.maximum('due_date').to_date,
              shared_versions.maximum('effective_date'),
              Issue.fixed_version(shared_versions).maximum('due_date').nil? ? nil : Issue.fixed_version(shared_versions).maximum('due_date').to_date
          ].compact.max
        end

        def overdue?
          active? && !due_date.nil? && (due_date < DateTime.now)
        end
      end
    end
  end
end