module RedmineIdd
  module CalendarPatch
    def self.included(base)
      base.class_eval do
        def events=(events)
          @events = events
          @ending_events_by_days = @events.group_by {|event| (event.due_date.is_a?(Date) || event.due_date.nil? ? event.due_date : event.due_date.to_date) }
          @starting_events_by_days = @events.group_by {|event| (event.start_date.is_a?(Date) || event.start_date.nil?  ? event.start_date : event.start_date.to_date) }
        end
      end
    end
  end
end