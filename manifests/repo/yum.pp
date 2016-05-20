# PRIVATE CLASS: do not use directly
class influxdb::repo::yum (
  $custom_repo   = undef,
  $custom_gpgkey = undef,
) {

  $_operatingsystem = $::operatingsystem ? {
    'CentOS' => downcase($::operatingsystem),
    default  => 'rhel',
  }

  $baseurl = $custom_repo ? {
    undef   => "https://repos.influxdata.com/${$_operatingsystem}/\$releasever/\$basearch/stable",
    default => $custom_repo,
  }
  $gpgkey = $custom_gpgkey ? {
    false   => absent,
    undef   => 'https://repos.influxdata.com/influxdb.key',
    default => $custom_gpgkey,
  }
  if $custom_gpgkey == false {
    $gpgcheck = 0
  }
  else {
    $gpgcheck = 1
  }

  yumrepo { 'repos.influxdata.com':
    descr    => "InfluxDB Repository - ${::operatingsystem} \$releasever",
    baseurl  => $baseurl,
    enabled  => 1,
    gpgcheck => $gpgcheck,
    gpgkey   => $gpgkey,
  }

  Yumrepo['repos.influxdata.com'] -> Package<| tag == 'influxdb' |>
}
