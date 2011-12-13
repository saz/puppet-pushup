define pushup::instance (
    $ensure = present,
    $adminBindAddress = '127.0.0.1',
    $adminPassword = 'password',
    $host_name = $::fqdn,
    $bindAddress = $::ipaddress,
    $service_ensure = running,
    $service_onboot = true,
    $service_disable = false,
    $monitor = false,
    $monitor_tool = false,
    $firewall = false,
    $firewall_tool = false,
    $firewall_src = false,
    $firewall_dst = $::ipaddress
) {
    include pushup::params, pushup::install

    $instance_name = "pushup-${name}"
    $instance_config = "${instance_name}.conf"
    $instance_config_full = "${pushup::params::config_dir}${instance_config}"

    file { $instance_config:
        ensure  => $ensure,
        path    => $instance_config_full,
        owner   => root,
        group   => root,
        mode    => 640,
        content => template("${module_name}/pushup-instance.conf.erb"),
        require => Class['pushup::install'],
        notify  => Service[$instance_name],
    }

    file { $instance_name:
        ensure  => $ensure,
        path    => "${pushup::params::init_base}${instance_name}",
        content => template("${module_name}/pushup.init.erb"),
        require => File[$instance_config],
        notify  => Service[$instance_name],
    }

    # TODO: add status command to init script
    service { $instance_name:
        ensure     => $service_disable ? {
            true  => stopped,
            false => $ensure ? {
                absent  => stopped,
                present => $service_ensure,
            },
        },
        enable     => $service_disable ? {
            true  => false,
            false => $ensure ? {
                absent  => false,
                present => $service_onboot,
            },
        },
        hasstatus  => false,
        hasrestart => true,
        pattern    => "${pushup::params::daemon} -f ${instance_config_full}",
        require    => File[$instance_name],
    }
}
