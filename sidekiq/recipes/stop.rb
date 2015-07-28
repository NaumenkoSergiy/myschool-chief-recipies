node[:deploy].each do |application, deploy|
  Chef::Log.info("test")
  release_path = ::File.join(deploy[:deploy_to], 'current')
  execute "test" do
    cwd release_path
    command "pkill -f sidekiq"
  end
end
