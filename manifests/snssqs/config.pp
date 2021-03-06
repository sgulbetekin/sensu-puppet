# @summary Sets the Sensu sensu config
#
# Sets the Sensu sensu config
#
class sensu::snssqs::config {

  if $::sensu::_purge_config and !$::sensu::enterprise and $::sensu::transport_type != 'snssqs' {
    $ensure = 'absent'
  } else {
    $ensure = 'present'
  }

  file { "${sensu::conf_dir}/snssqs.json":
    ensure => $ensure,
    owner  => $::sensu::user,
    group  => $::sensu::group,
    mode   => $::sensu::file_mode,
    before => Sensu_snssqs_config[$::fqdn],
  }

  $base_path                = $::sensu::conf_dir
  $region                   = $::sensu::snssqs_region
  $max_messages             = $::sensu::snssqs_max_messages 
  $wait_time_seconds        = $::sensu::snssqs_wait_time_seconds
  $consuming_sqs_queue_url  = $::sensu::snssqs_queue_url
  $publishing_sns_topic_arn = $::sensu::snssqs_topic_arn

  sensu_snssqs_config { $::fqdn:
    ensure                   => $ensure,
    base_path                => $base_path,
    region                   => $region,
    max_messages             => $max_messages,
    wait_time_seconds        => $wait_time_seconds,
    consuming_sqs_queue_url  => $consuming_sqs_queue_url,
    publishing_sns_topic_arn => $publishing_sns_topic_arn,
  }

}
