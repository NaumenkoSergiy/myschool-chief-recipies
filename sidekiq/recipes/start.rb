node[:deploy].each do |application, deploy|
  Chef::Log.info("test")
  release_path = ::File.join(deploy[:deploy_to], 'current')

  # execute "start" do
    # OpsWorks::Sidekiq.kill_all_sidekiq
  bash 'start-sidekiq' do
    code <<-EOH
    (cd /srv/www/myschool_staging/current/)
    (bundle exec sidekiq -C config/myschool_sidekiq.yml -d -L log/sidekiq.log)
    EOH
  end
    # command "bundle exec sidekiq -C config/myschool_sidekiq.yml -d -L log/sidekiq.log"
    # environment "RAILS_ENV" => 'staging'
  # end
end
