module RedmineIdd
  module GanttPatch
    def self.included(base)
      base.class_eval do
        def coordinates(start_date, end_date, progress, zoom=nil)
          start_date = start_date.to_date if not start_date.nil?
          end_date = end_date.to_date if not end_date.nil?

          zoom ||= @zoom
          coords = {}
          if start_date && end_date && start_date < self.date_to && end_date > self.date_from
            if start_date > self.date_from
              coords[:start] = start_date - self.date_from
              coords[:bar_start] = start_date - self.date_from
            else
              coords[:bar_start] = 0
            end
            if end_date < self.date_to
              coords[:end] = end_date - self.date_from
              coords[:bar_end] = end_date - self.date_from + 1
            else
              coords[:bar_end] = self.date_to - self.date_from + 1
            end
            if progress
              progress_date = calc_progress_date(start_date, end_date, progress)
              if progress_date > self.date_from && progress_date > start_date
                if progress_date < self.date_to
                  coords[:bar_progress_end] = progress_date - self.date_from
                else
                  coords[:bar_progress_end] = self.date_to - self.date_from + 1
                end
              end
              if progress_date < Date.today
                late_date = [Date.today, end_date].min
                if late_date > self.date_from && late_date > start_date
                  if late_date < self.date_to
                    coords[:bar_late_end] = late_date - self.date_from + 1
                  else
                    coords[:bar_late_end] = self.date_to - self.date_from + 1
                  end
                end
              end
            end
          end
          # Transforms dates into pixels witdh
          coords.keys.each do |key|
            coords[key] = (coords[key] * zoom).floor
          end
          coords
        end

        def calc_progress_date(start_date, end_date, progress)
          start_date.to_date + (end_date.to_date - start_date.to_date + 1) * (progress / 100.0)
        end
      end
    end
  end
end
