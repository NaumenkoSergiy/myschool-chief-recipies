module OpsWorks
  module Sidekiq
    def self.kill_all_sidekiq
      bash 'test' do
        code <<-EOH
          (ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9)
        EOH
      end
    end
  end
end
