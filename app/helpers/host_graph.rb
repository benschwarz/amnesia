module Amnesia
  module Helpers
    module HostGraph
      def graph_url(data = [], labels = [])
        GChart.pie(:data => data, :size => '115x115').to_url
      end
    end
  end
end