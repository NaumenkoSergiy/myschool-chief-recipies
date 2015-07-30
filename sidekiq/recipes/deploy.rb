node[:deploy].each do |application, deploy|
  Chef::Log.info("Restarting sidekiq...")
  release_path = ::File.join(deploy[:deploy_to], 'current')

  execute "restart sidekiq" do
    cwd release_path
    command "kill -9 `cat tmp/pids/sidekiq.pid`; bundle exec sidekiq -C config/myschool_sidekiq.yml -d -L log/sidekiq.log -P tmp/pids/sidekiq.pid"
    environment "RAILS_ENV" => 'staging'
  end
end
