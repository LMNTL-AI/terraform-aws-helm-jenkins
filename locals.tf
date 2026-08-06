locals {
  default_fqdn = "${var.jenkins_dns_name}.${var.domain}"
  jenkins_fqdn = var.jenkins_fqdn != "" ? var.jenkins_fqdn : local.default_fqdn

  # Effective list of global shared-library names. Defaults to the single
  # shared_lib_name for backward compatibility; set shared_lib_names to register
  # multiple aliases (e.g. during a library rename) so both resolve durably.
  shared_lib_names = length(var.shared_lib_names) > 0 ? var.shared_lib_names : [var.shared_lib_name]

  general_secret_configs = flatten([
    for key, value in var.general_secrets :
    {
      secret_key   = key
      secret_value = value
    }
  ])

  admin_user_list    = var.google_user_list.admin
  executor_user_list = var.google_user_list.executor
  viewer_user_list   = var.google_user_list.viewer
}
