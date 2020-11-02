git_plugin = self

namespace :puma do
  namespace :systemd do
    desc 'Config Puma systemd service'
    task :config do
      on roles(fetch(:puma_role)) do |role|
        unit_filename = "#{fetch(:puma_service_unit_name)}.service"
        git_plugin.template_puma unit_filename, "#{fetch(:tmp_dir)}/#{unit_filename}", role
        sudo "mv #{fetch(:tmp_dir)}/#{unit_filename} #{fetch(:puma_systemd_conf_dir)}"
        sudo "#{fetch(:puma_systemctl_bin)} daemon-reload"
      end
    end

    desc 'Enable Puma systemd service'
    task :enable do
      on roles(fetch(:puma_role)) do |role|
        sudo "#{fetch(:puma_systemctl_bin)} enable puma"
      end
    end

    desc 'Disable Puma systemd service'
    task :disable do
      on roles(fetch(:puma_role)) do |role|
        sudo "#{fetch(:puma_systemctl_bin)} disable puma"
      end
    end

    desc 'Start Puma systemd service'
    task :start do
      on roles(fetch(:puma_role)) do |role|
        sudo "#{fetch(:puma_systemctl_bin)} start puma"
      end
    end

    desc 'Stop Puma systemd service'
    task :stop do
      on roles(fetch(:puma_role)) do |role|
        sudo "#{fetch(:puma_systemctl_bin)} stop puma"
      end
    end

    desc 'Restart Puma systemd service'
    task :restart do
      on roles(fetch(:puma_role)) do |role|
        sudo "#{fetch(:puma_systemctl_bin)} restart puma"
      end
    end
  end
end
