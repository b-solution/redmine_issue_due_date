module RedmineIdd
  module I18nPatch
    def self.included(base)
      base.class_eval do
        def localise_date(date)
          return if date.nil?

          zone = User.current.time_zone
          local = zone ? date.in_time_zone(zone) : date
          return local
        end
      end
    end
  end
end