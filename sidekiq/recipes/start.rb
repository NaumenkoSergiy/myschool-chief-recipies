bash "test" do
  user 'root'
  code <<-EOC
    ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9
  EOC
end

node[:deploy].each do |application, deploy|
  Chef::Log.info("test")
  release_path = ::File.join(deploy[:deploy_to], 'current')

  execute "start" do
    cwd release_path
    command "bundle exec sidekiq -C config/myschool_sidekiq.yml -d -L log/sidekiq.log"
    environment "RAILS_ENV" => 'staging'
  end
end

