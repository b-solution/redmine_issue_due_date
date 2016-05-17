module RedmineIdd
  module VersionPatch
    def self.included(base)
      base.class_eval do
        def behind_schedule?
          if completed_percent == 100
            return false
          elsif due_date && start_date
            done_date = start_date.to_date + ((due_date.to_date - start_date.to_date + 1) * completed_percent/100).floor
            return done_date <= Date.today
          else
            false # No issues so it's not late
          end
        end
      end
    end
  end
end