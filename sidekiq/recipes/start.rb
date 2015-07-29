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
    command "x=`ps aux | grep sidekiq | grep -v grep | awk '{print $2}'`; [ '$x' == '' ] && bundle exec sidekiq -d -L log/sidekiq.log -C config/myschool_sidekiq.yml -e staging"
    environment "RAILS_ENV" => 'staging'
  end
end
