node[:deploy].each do |application, deploy|
  Chef::Log.info("test")
  release_path = ::File.join(deploy[:deploy_to], 'current')

  execute "start" do
    cwd release_path
    command "ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9 && bundle exec sidekiq -C config/myschool_sidekiq.yml -d -L log/sidekiq.log -p tmp/pids/sidekiq.pid"
    environment "RAILS_ENV" => 'staging'
  end
end

