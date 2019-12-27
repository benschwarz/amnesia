module Amnesia
  module Helpers
    def self.included app
      app.helpers do
        include HelperMethods
      end
    end

    module HelperMethods
      SIZE_UNITS = %w[ Bytes KB MB GB TB PB EB ]

      def graph_url(*data)
        Gchart.pie(data: data, size: '115x115', bg: 'ffffff00')
      end

      # https://github.com/rails/rails/blob/fbe335cfe09bf0949edfdf0c4b251f4d081bd5d7/activesupport/lib/active_support/number_helper/number_to_human_size_converter.rb
      def number_to_human_size(number, precision=1)
        number, base = Float(number), 1024

        if number.to_i < base
          "%d %s" % [ number.to_i, SIZE_UNITS.first ]
        else
          max = SIZE_UNITS.size - 1
          exp = (Math.log(number) / Math.log(base)).to_i
          exp = max if exp > max # avoid overflow for the highest unit
          result = number / (base**exp)
          "%.#{precision}f %s" % [ result, SIZE_UNITS[exp] ]
        end
      end

      def alive_hosts
        @alive_hosts ||= @hosts.select(&:alive?)
      end

      %w[ bytes limit_maxbytes get_hits get_misses cmd_get cmd_set ].each do |stat|
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{stat}_sum
            alive_hosts.map(&:#{stat}).sum
          end
        RUBY
      end
    end
  end
end
