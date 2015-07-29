node[:deploy].each do |application, deploy|
  Chef::Log.info("test")
  release_path = ::File.join(deploy[:deploy_to], 'current')

  execute "start" do
    cwd release_path
    command "ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9;"
    environment "RAILS_ENV" => 'staging'
  end
end

