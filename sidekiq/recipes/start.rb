node[:deploy].each do |application, deploy|
  Chef::Log.info("test")
  release_path = ::File.join(deploy[:deploy_to], 'current')

  file 'tmp/pids/sidekiq.pid' do
    action :delete
    backup false
  end

  execute "start" do
    cwd release_path
    command "bundle exec sidekiq -C config/myschool_sidekiq.yml -d -L log/sidekiq.log -p tmp/pids/sidekiq.pid"
    environment "RAILS_ENV" => 'staging'
  end
end

