module RedmineIdd
module ApplicationHelperPatch
  def self.included(base)
    base.class_eval do
      def time_select_tag( name, stime, options = {} )
        time = stime.to_time(:utc)
        if time.nil?
          selected = {:hour => '', :min => ''}
        else
          zone = User.current.time_zone
          time = zone ? time.in_time_zone(zone) : (time.utc? ? time.localtime : time)
          selected = {:hour => time.hour, :min => time.min}
        end

        out = ''

        if options[:required]
          hours = []
          mins = []
        else
          hours = [['', '']]
          mins = [['', '']]
        end

        hours += (0..23).map{|i| ['%02d' % i, i] } # Zero pad
        out << select_tag(
            "#{name}[hour]",
            options_for_select( hours, selected[:hour] ),
            :style => 'min-width: 10px;max-width: 50px;'
        )

        out << ':'
        mins += (0..59).map{|i| ['%02d' % i, i] } # Zero pad
        out << select_tag(
            "#{name}[minute]",
            options_for_select( mins, selected[:min] ),
            :style => 'min-width: 10px;max-width: 50px;'
        )
      end

      def calendar_for_issue(field_id)
        include_calendar_headers_tags
        javascript_tag("$(function() { $('##{field_id}').addClass('date').datetimepicker(datepickerOptions); });")
      end
    end
  end
end

end