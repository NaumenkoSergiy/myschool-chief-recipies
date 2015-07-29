module OpsWorks
  module Sidekiq
    def self.kill_all_sidekiq
      bash { code << "ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9" }
    end
  end
end
