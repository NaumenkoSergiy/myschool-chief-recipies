node[:deploy].each do |application, deploy|
  Chef::Log.info("test")
  release_path = ::File.join(deploy[:deploy_to], 'current')

  # execute "start" do
    # OpsWorks::Sidekiq.kill_all_sidekiq
  code <<-EOH
  (cd #{release_path})
  (pkill -f sidekiq)
  (bundle exec sidekiq -C config/myschool_sidekiq.yml -d -L log/sidekiq.log)
  EOH
    # command "bundle exec sidekiq -C config/myschool_sidekiq.yml -d -L log/sidekiq.log"
    # environment "RAILS_ENV" => 'staging'
  # end
end
