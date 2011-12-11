class pushup::config {
    file { $pushup::params::config_file:
        ensure  => present,
        owner   => root,
        group   => root,
        mode    => 640,
        content => template("${module_name}/pushup.conf.erb"),
        require => Class['pushup::install'],
        notify  => Class['pushup::service'],
    }
}
