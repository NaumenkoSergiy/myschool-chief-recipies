module OpsWorks
  module Sidekiq
    def self.kill_all_sidekiq
      Chef::Log.info("Killing all processes of sidekiq")
      execute "kill all processes of user sidekiq" do
        command "pkill -f sidekiq; true"
      end
    end
  end
end
