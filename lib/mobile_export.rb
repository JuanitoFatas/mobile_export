require "mobile_export/version"
require "mobile_export/android"

module MobileExport
  class CLI
    def self.execute
      Android.new.run
    end
  end
end
