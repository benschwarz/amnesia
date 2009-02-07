module Amnesia
  module Helpers
    module HostGraph
      def graph_url(data = {})
        pc = GoogleChart::PieChart.new
        data.each_pair do |k,v|
          pc.data k, v
        end
    
        return pc.to_url
      end
    end
  end
end