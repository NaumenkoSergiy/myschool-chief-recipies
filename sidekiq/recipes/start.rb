# bash "test" do
#   user 'root'
#   code <<-EOC
#     ( sudo pkill -f sidekiq; true )
#   EOC
# end

node[:deploy].each do |application, deploy|
  Chef::Log.info("test")
  release_path = ::File.join(deploy[:deploy_to], 'current')

  execute "start" do
    cwd release_path
    command "bundle exec sidekiq -C config/myschool_sidekiq.yml -d -L log/sidekiq.log -P tmp/pids/sidekiq.pid"
    environment "RAILS_ENV" => 'staging'
  end
end
