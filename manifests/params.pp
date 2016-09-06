class xss_validator::params {
  case $::osfamily {
    'Debian': {
      $install_location='/opt/xss_validator'
    }

    default: {
      fail("Unsupported OS family: ${::osfamily}")
    }
  }
  $commons_codec_download_location='http://central.maven.org/maven2/commons-codec/commons-codec/1.6/commons-codec-1.6.jar'
  $commons_logging_download_location='http://central.maven.org/maven2/commons-logging/commons-logging/1.1.3/commons-logging-1.1.3.jar'
  $fluent_hc_download_location='http://central.maven.org/maven2/org/apache/httpcomponents/fluent-hc/4.3.6/fluent-hc-4.3.6.jar'
  $httpclient_download_location='http://central.maven.org/maven2/org/apache/httpcomponents/httpclient/4.3.6/httpclient-4.3.6.jar'
  $httpclient_cache_download_location='http://central.maven.org/maven2/org/apache/httpcomponents/httpclient-cache/4.3.6/httpclient-cache-4.3.6.jar'
  $httpcore_download_location='http://central.maven.org/maven2/org/apache/httpcomponents/httpcore/4.3.3/httpcore-4.3.3.jar'
  $httpmime_download_location='http://central.maven.org/maven2/org/apache/httpcomponents/httpmime/4.3.6/httpmime-4.3.6.jar'
  $dependencies = [
    $commons_codec_download_location,
    $commons_logging_download_location,
    $fluent_hc_download_location,
    $httpclient_download_location,
    $httpclient_cache_download_location,
    $httpcore_download_location,
    $httpmime_download_location,
  ]
}
