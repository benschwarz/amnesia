module Amnesia
  module Helpers
   module Number
     def number_to_human_size(size, precision=1)
       size = Kernel.Float(size)
       case
         when size.to_i == 1;    "1 Byte"
         when size < 1.kilobyte; "%d Bytes" % size
         when size < 1.megabyte; "%.#{precision}f KB"  % (size / 1.0.kilobyte)
         when size < 1.gigabyte; "%.#{precision}f MB"  % (size / 1.0.megabyte)
         when size < 1.terabyte; "%.#{precision}f GB"  % (size / 1.0.gigabyte)
         else                    "%.#{precision}f TB"  % (size / 1.0.terabyte)
       end.sub(/([0-9])\.?0+ /, '\1 ' )
     rescue
       nil
     end
   end
  end
end