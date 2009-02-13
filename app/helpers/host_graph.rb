module Amnesia
  module Helpers
    module HostGraph
      def graph_url(data = [], labels = [])
        Gchart.pie(:data => data, :size => '115x115')
      end
    end
  end
end