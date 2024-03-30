# Debug Apache 500 Server Error

package { 'nginx': # Ensure the nginx package is installed
    ensure => installed,
}

service { 'nginx': # Manage the nginx service
    ensure => 'running',
    enable => true, # Ensure the service starts on boot
}

exec { 'update_nginx_ulimit': # Define the exec resource for updating nginx ulimit
    command  => 'sed -i "s/ULIMIT=\"-n 15\"/ULIMIT=\"-n 4096\"/g" /etc/default/nginx',
    provider => 'shell',
    require  => Package['nginx'], # Ensure this exec runs after nginx package is installed
    notify   => Service['nginx']
}

