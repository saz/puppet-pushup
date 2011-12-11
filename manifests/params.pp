class pushup::params {
    case $::operatingsystem {
        /(Ubuntu|Debian)/: {
            $package_name = 'pushup'
            $service_name = 'pushup'
            $config_file = '/etc/pushup.conf'
            $config_dir = '/etc/'
            $init_base = '/etc/init.d/'
            $init_script = "${init_base}pushup"
            $daemon = '/usr/sbin/pushup'
        }
    }
}
