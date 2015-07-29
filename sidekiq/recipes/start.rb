bash "test" do
  user 'root'
  code <<-EOC
    kill -9 9379
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

