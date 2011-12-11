define pushup::instance ($adminBindAddress = '127.0.0.1', $adminPassword = 'password', $host_name = $::fqdn, $bindAddress = $::ipaddress) {
    include pushup::params, pushup::install

    $instance_name = "pushup-${name}"
    $instance_config = "${instance_name}.conf"
    $instance_config_full = "${pushup::params::config_dir}${instance_config}"

    file { $instance_config:
        ensure  => present,
        path    => $instance_config_full,
        owner   => root,
        group   => root,
        mode    => 640,
        content => template("${module_name}/pushup-instance.conf.erb"),
        require => Class['pushup::install'],
        notify  => Service[$instance_name],
    }

    file { "${instance_name}":
        ensure  => link,
        path    => "${pushup::params::init_base}${instance_name}",
        target  => $pushup::params::init_script,
        require => File[$instance_config],
        notify  => Service[$instance_name],
    }

    service { $instance_name:
        ensure     => running,
        enable     => true,
        hasstatus  => false,
        hasrestart => true,
        pattern    => "${pushup::params::daemon} -f ${instance_config_full}",
        require    => File[$instance_name],
    }
}
