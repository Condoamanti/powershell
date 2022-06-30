# TrueNAS
## Documentation:
- https://www.powershellgallery.com/packages/TrueNas/21.3.15-alpha

## Configuration:
```
$AccessToken = "<REFERENCE_VAULT>"
Remove-Module -Name TrueNAS -Verbose; Import-Module -Name TrueNAS -Verbose; $(Connect-TrueNASServer -ServerName truenas.domain.local -AccessToken $AccessToken -Verbose)
```

### Example:
```
Clear-Host
$ServerName = "truenas1dc1.domain.local"
$Port = "443"
$ApiVersion = "v2.0"
$BaseUri = "https://$($ServerName):$($Port)/api/$($ApiVersion)"
$ApiEndpoint = ""
$FullUri = $BaseUri

$AccessToken = "<REFERENCE_VAULT>"

$Headers = @{}
$Headers.Add("Authorization", "Bearer $AccessToken")
$Headers.Add("Content-Type", "application/json")

# Invoke web request call to TrueNAS system info endpoint
$WebRequest = Invoke-WebRequest -Uri "$BaseUri/vm" -Headers $Headers -Method "Get" -ContentType "application/json"
$WebRequestContent = $WebRequest.Content | ConvertFrom-Json
```

## Pester:
### Documentation:
1. https://pester-docs.netlify.app/docs/commands/Add-ShouldOperator#synopsis
2. https://jeffbrown.tech/working-with-pester-should-command-and-operators/

### Execution:
```
Invoke-Pester -Output Detailed -Path .\pester\*.Tests.ps1
```

## Endpoints:
```
$WebRequest = Invoke-WebRequest -Uri "$BaseUri" -Headers $Headers -Method "Get" -ContentType "application/json" | ConvertFrom-Json
$WebRequest.paths
---
/core/bulk                                         : @{post=}
/core/debug                                        : @{post=}
/core/download                                     : @{post=}
/core/get_events                                   : @{get=}
/core/get_jobs                                     : @{get=}
/core/get_methods                                  : @{post=}
/core/get_services                                 : @{get=}
/core/job_abort                                    : @{post=}
/core/job_update                                   : @{post=}
/core/job_wait                                     : @{post=}
/core/ping                                         : @{get=}
/core/ping_remote                                  : @{post=}
/core/resize_shell                                 : @{post=}
/core/sessions                                     : @{get=}
/acme/dns/authenticator                            : @{get=; post=}
/acme/dns/authenticator/id/{id}                    : @{delete=; get=; put=}
/acme/dns/authenticator/authenticator_schemas      : @{get=}
/activedirectory                                   : @{get=; put=}
/activedirectory/change_trust_account_pw           : @{get=}
/activedirectory/domain_info                       : @{get=}
/activedirectory/get_spn_list                      : @{get=}
/activedirectory/get_state                         : @{get=}
/activedirectory/leave                             : @{post=}
/activedirectory/nss_info_choices                  : @{get=}
/activedirectory/started                           : @{get=}
/afp                                               : @{get=; put=}
/afp/bindip_choices                                : @{get=}
/alert/dismiss                                     : @{post=}
/alert/list                                        : @{get=}
/alert/list_categories                             : @{get=}
/alert/list_policies                               : @{get=}
/alert/restore                                     : @{post=}
/alertclasses                                      : @{get=; put=}
/alertservice                                      : @{get=; post=}
/alertservice/id/{id}                              : @{delete=; get=; put=}
/alertservice/list_types                           : @{get=}
/alertservice/test                                 : @{post=}
/api_key                                           : @{get=; post=}
/api_key/id/{id}                                   : @{delete=; get=; put=}
/auth/check_password                               : @{post=}
/auth/check_user                                   : @{post=}
/auth/generate_token                               : @{post=}
/auth/sessions                                     : @{get=}
/auth/two_factor_auth                              : @{get=}
/auth/twofactor                                    : @{get=; put=}
/auth/twofactor/provisioning_uri                   : @{get=}
/auth/twofactor/renew_secret                       : @{get=}
/auth/twofactor/verify                             : @{post=}
/boot/attach                                       : @{post=}
/boot/detach                                       : @{post=}
/boot/get_disks                                    : @{get=}
/boot/get_scrub_interval                           : @{get=}
/boot/get_state                                    : @{get=}
/boot/replace                                      : @{post=}
/boot/scrub                                        : @{get=}
/boot/set_scrub_interval                           : @{post=}
/bootenv                                           : @{get=; post=}
/bootenv/id/{id}                                   : @{delete=; get=; put=}
/bootenv/id/{id}/activate                          : @{post=}
/bootenv/id/{id}/set_attribute                     : @{post=}
/certificate                                       : @{get=; post=}
/certificate/id/{id}                               : @{delete=; get=; put=}
/certificate/acme_server_choices                   : @{get=}
/certificate/country_choices                       : @{get=}
/certificate/ec_curve_choices                      : @{get=}
/certificate/extended_key_usage_choices            : @{get=}
/certificate/key_type_choices                      : @{get=}
/certificate/profiles                              : @{get=}
/certificateauthority                              : @{get=; post=}
/certificateauthority/id/{id}                      : @{delete=; get=; put=}
/certificateauthority/ca_sign_csr                  : @{post=}
/certificateauthority/profiles                     : @{get=}
/cloudsync                                         : @{get=; post=}
/cloudsync/id/{id}                                 : @{delete=; get=; put=}
/cloudsync/id/{id}/abort                           : @{post=}
/cloudsync/common_task_schema                      : @{get=}
/cloudsync/list_buckets                            : @{post=}
/cloudsync/list_directory                          : @{post=}
/cloudsync/onedrive_list_drives                    : @{post=}
/cloudsync/providers                               : @{get=}
/cloudsync/id/{id}/restore                         : @{post=}
/cloudsync/id/{id}/sync                            : @{post=}
/cloudsync/sync_onetime                            : @{post=}
/cloudsync/credentials                             : @{get=; post=}
/cloudsync/credentials/id/{id}                     : @{delete=; get=; put=}
/cloudsync/credentials/verify                      : @{post=}
/config/reset                                      : @{post=}
/cronjob                                           : @{get=; post=}
/cronjob/id/{id}                                   : @{delete=; get=; put=}
/cronjob/run                                       : @{post=}
/device/get_info                                   : @{post=}
/directoryservices/cache_refresh                   : @{get=}
/directoryservices/get_state                       : @{get=}
/disk                                              : @{get=}
/disk/id/{id}                                      : @{get=; put=}
/disk/get_encrypted                                : @{post=}
/disk/get_unused                                   : @{post=}
/disk/label_to_dev                                 : @{get=}
/disk/label_to_dev_disk_cache                      : @{get=}
/disk/overprovision                                : @{post=}
/disk/sed_dev_name                                 : @{get=}
/disk/smart_attributes                             : @{post=}
/disk/spindown                                     : @{post=}
/disk/temperature                                  : @{post=}
/disk/temperatures                                 : @{post=}
/disk/unoverprovision                              : @{post=}
/disk/wipe                                         : @{post=}
/dns/query                                         : @{get=}
/dyndns                                            : @{get=; put=}
/dyndns/provider_choices                           : @{get=}
/ec2/Meta                                          : @{get=}
/ec2/instance_id                                   : @{get=}
/ec2/set_ntp_servers                               : @{get=}
/ec2/set_root_ssh_public_key                       : @{get=}
/ec2/setup                                         : @{get=}
/enclosure                                         : @{get=}
/enclosure/id/{id}                                 : @{get=; put=}
/enclosure/set_slot_status                         : @{post=}
/failover                                          : @{get=; put=}
/failover/call_remote                              : @{post=}
/failover/control                                  : @{post=}
/failover/force_master                             : @{get=}
/failover/hardware                                 : @{get=}
/failover/in_progress                              : @{get=}
/failover/licensed                                 : @{get=}
/failover/node                                     : @{get=}
/failover/status                                   : @{get=}
/failover/sync_from_peer                           : @{get=}
/failover/sync_to_peer                             : @{post=}
/failover/unlock                                   : @{post=}
/failover/upgrade                                  : @{post=}
/failover/upgrade_finish                           : @{get=}
/failover/upgrade_pending                          : @{get=}
/fcport                                            : @{get=}
/fcport/id/{id}                                    : @{get=; put=}
/filesystem/acl_is_trivial                         : @{post=}
/filesystem/chown                                  : @{post=}
/filesystem/default_acl_choices                    : @{get=}
/filesystem/get_default_acl                        : @{post=}
/filesystem/getacl                                 : @{post=}
/filesystem/listdir                                : @{post=}
/filesystem/setacl                                 : @{post=}
/filesystem/setperm                                : @{post=}
/filesystem/stat                                   : @{post=}
/filesystem/statfs                                 : @{post=}
/ftp                                               : @{get=; put=}
/group                                             : @{get=; post=}
/group/id/{id}                                     : @{delete=; get=; put=}
/group/get_group_obj                               : @{post=}
/group/get_next_gid                                : @{get=}
/idmap                                             : @{get=; post=}
/idmap/id/{id}                                     : @{delete=; get=; put=}
/idmap/backend_choices                             : @{get=}
/idmap/backend_options                             : @{get=}
/idmap/clear_idmap_cache                           : @{get=}
/idmap/options_choices                             : @{post=}
/initshutdownscript                                : @{get=; post=}
/initshutdownscript/id/{id}                        : @{delete=; get=; put=}
/interface                                         : @{get=; post=}
/interface/id/{id}                                 : @{delete=; get=; put=}
/interface/bridge_members_choices                  : @{post=}
/interface/checkin                                 : @{get=}
/interface/checkin_waiting                         : @{get=}
/interface/choices                                 : @{post=}
/interface/commit                                  : @{post=}
/interface/enable_capabilities_individually        : @{get=}
/interface/has_pending_changes                     : @{get=}
/interface/ip_in_use                               : @{post=}
/interface/lag_ports_choices                       : @{post=}
/interface/lag_setup                               : @{get=}
/interface/rollback                                : @{get=}
/interface/vlan_parent_interface_choices           : @{get=}
/interface/vlan_setup                              : @{get=}
/ipmi                                              : @{get=}
/ipmi/id/{id}                                      : @{get=; put=}
/ipmi/channels                                     : @{get=}
/ipmi/identify                                     : @{post=}
/ipmi/is_loaded                                    : @{get=}
/iscsi/auth                                        : @{get=; post=}
/iscsi/auth/id/{id}                                : @{delete=; get=; put=}
/iscsi/extent                                      : @{get=; post=}
/iscsi/extent/id/{id}                              : @{delete=; get=; put=}
/iscsi/extent/disk_choices                         : @{post=}
/iscsi/global                                      : @{get=; put=}
/iscsi/global/alua_enabled                         : @{get=}
/iscsi/global/sessions                             : @{get=}
/iscsi/initiator                                   : @{get=; post=}
/iscsi/initiator/id/{id}                           : @{delete=; get=; put=}
/iscsi/portal                                      : @{get=; post=}
/iscsi/portal/id/{id}                              : @{delete=; get=; put=}
/iscsi/portal/listen_ip_choices                    : @{get=}
/iscsi/target                                      : @{get=; post=}
/iscsi/target/id/{id}                              : @{delete=; get=; put=}
/iscsi/targetextent                                : @{get=; post=}
/iscsi/targetextent/id/{id}                        : @{delete=; get=; put=}
/jail                                              : @{get=; post=}
/jail/id/{id}                                      : @{delete=; get=; put=}
/jail/activate                                     : @{post=}
/jail/clean                                        : @{post=}
/jail/id/{id}/clone                                : @{post=}
/jail/default_configuration                        : @{get=}
/jail/exec                                         : @{post=}
/jail/export                                       : @{post=}
/jail/fetch                                        : @{post=}
/jail/fstab                                        : @{post=}
/jail/get_activated_pool                           : @{get=}
/jail/import_image                                 : @{post=}
/jail/interface_choices                            : @{get=}
/jail/rc_action                                    : @{post=}
/jail/releases_choices                             : @{post=}
/jail/restart                                      : @{post=}
/jail/start                                        : @{post=}
/jail/stop                                         : @{post=}
/jail/update_defaults                              : @{post=}
/jail/update_to_latest_patch                       : @{post=}
/jail/vnet_default_interface_choices               : @{get=}
/kerberos                                          : @{get=; put=}
/kerberos/keytab                                   : @{get=; post=}
/kerberos/keytab/id/{id}                           : @{delete=; get=; put=}
/kerberos/keytab/system_keytab_list                : @{get=}
/kerberos/realm                                    : @{get=; post=}
/kerberos/realm/id/{id}                            : @{delete=; get=; put=}
/keychaincredential                                : @{get=; post=}
/keychaincredential/id/{id}                        : @{delete=; get=; put=}
/keychaincredential/generate_ssh_key_pair          : @{get=}
/keychaincredential/remote_ssh_host_key_scan       : @{post=}
/keychaincredential/remote_ssh_semiautomatic_setup : @{post=}
/keychaincredential/used_by                        : @{post=}
/kmip                                              : @{get=; put=}
/kmip/clear_sync_pending_keys                      : @{get=}
/kmip/kmip_sync_pending                            : @{get=}
/kmip/sync_keys                                    : @{get=}
/ldap                                              : @{get=; put=}
/ldap/get_state                                    : @{get=}
/ldap/schema_choices                               : @{get=}
/ldap/ssl_choices                                  : @{get=}
/lldp                                              : @{get=; put=}
/lldp/country_choices                              : @{get=}
/mail                                              : @{get=; put=}
/mail/send                                         : @{post=}
/multipath                                         : @{get=}
/multipath/id/{id}                                 : @{get=}
/network/configuration                             : @{get=; put=}
/network/general/summary                           : @{get=}
/nfs                                               : @{get=; put=}
/nfs/add_principal                                 : @{post=}
/nfs/bindip_choices                                : @{get=}
/nis                                               : @{get=; put=}
/nis/get_state                                     : @{get=}
/openvpn/client                                    : @{get=; put=}
/openvpn/client/authentication_algorithm_choices   : @{get=}
/openvpn/client/cipher_choices                     : @{get=}
/openvpn/server                                    : @{get=; put=}
/openvpn/server/authentication_algorithm_choices   : @{get=}
/openvpn/server/cipher_choices                     : @{get=}
/openvpn/server/client_configuration_generation    : @{post=}
/openvpn/server/renew_static_key                   : @{get=}
/plugin                                            : @{get=; post=}
/plugin/id/{id}                                    : @{delete=; get=; put=}
/plugin/available                                  : @{post=}
/plugin/branches_choices                           : @{post=}
/plugin/defaults                                   : @{post=}
/plugin/official_repositories                      : @{get=}
/plugin/retrieve_versions_for_repos                : @{get=}
/plugin/update_plugin                              : @{post=}
/pool                                              : @{get=; post=}
/pool/id/{id}                                      : @{get=; put=}
/pool/attach                                       : @{post=}
/pool/id/{id}/attachments                          : @{post=}
/pool/id/{id}/detach                               : @{post=}
/pool/id/{id}/download_encryption_key              : @{post=}
/pool/id/{id}/expand                               : @{post=}
/pool/id/{id}/export                               : @{post=}
/pool/filesystem_choices                           : @{post=}
/pool/id/{id}/get_disks                            : @{post=}
/pool/import_disk                                  : @{post=}
/pool/import_disk_autodetect_fs_type               : @{post=}
/pool/import_disk_msdosfs_locales                  : @{get=}
/pool/import_find                                  : @{get=}
/pool/import_pool                                  : @{post=}
/pool/id/{id}/is_upgraded                          : @{post=}
/pool/id/{id}/lock                                 : @{post=}
/pool/id/{id}/offline                              : @{post=}
/pool/id/{id}/online                               : @{post=}
/pool/id/{id}/passphrase                           : @{post=}
/pool/id/{id}/processes                            : @{post=}
/pool/id/{id}/recoverykey_rm                       : @{post=}
/pool/id/{id}/rekey                                : @{post=}
/pool/id/{id}/remove                               : @{post=}
/pool/id/{id}/replace                              : @{post=}
/pool/id/{id}/scrub                                : @{post=}
/pool/id/{id}/unlock                               : @{post=}
/pool/unlock_services_restart_choices              : @{post=}
/pool/id/{id}/upgrade                              : @{post=}
/pool/dataset                                      : @{get=; post=}
/pool/dataset/id/{id}                              : @{delete=; get=; put=}
/pool/dataset/id/{id}/attachments                  : @{post=}
/pool/dataset/change_key                           : @{post=}
/pool/dataset/checksum_choices                     : @{get=}
/pool/dataset/compression_choices                  : @{get=}
/pool/dataset/encryption_algorithm_choices         : @{get=}
/pool/dataset/encryption_summary                   : @{post=}
/pool/dataset/export_key                           : @{post=}
/pool/dataset/id/{id}/get_quota                    : @{post=}
/pool/dataset/inherit_parent_encryption_properties : @{post=}
/pool/dataset/lock                                 : @{post=}
/pool/dataset/id/{id}/permission                   : @{post=}
/pool/dataset/id/{id}/processes                    : @{post=}
/pool/dataset/id/{id}/promote                      : @{post=}
/pool/dataset/recommended_zvol_blocksize           : @{post=}
/pool/dataset/id/{id}/set_quota                    : @{post=}
/pool/dataset/unlock                               : @{post=}
/pool/dataset/userprop                             : @{get=; post=}
/pool/dataset/userprop/id/{id}                     : @{delete=; get=; put=}
/pool/resilver                                     : @{get=; put=}
/pool/scrub                                        : @{get=; post=}
/pool/scrub/id/{id}                                : @{delete=; get=; put=}
/pool/scrub/run                                    : @{post=}
/pool/snapshottask                                 : @{get=; post=}
/pool/snapshottask/id/{id}                         : @{delete=; get=; put=}
/pool/snapshottask/id/{id}/run                     : @{post=}
/replication                                       : @{get=; post=}
/replication/id/{id}                               : @{delete=; get=; put=}
/replication/count_eligible_manual_snapshots       : @{post=}
/replication/create_dataset                        : @{post=}
/replication/list_datasets                         : @{post=}
/replication/list_naming_schemas                   : @{get=}
/replication/id/{id}/restore                       : @{post=}
/replication/id/{id}/run                           : @{post=}
/replication/target_unmatched_snapshots            : @{post=}
/replication/config                                : @{get=; put=}
/reporting                                         : @{get=; put=}
/reporting/clear                                   : @{get=}
/reporting/get_data                                : @{post=}
/reporting/graphs                                  : @{get=}
/route/ipv4gw_reachable                            : @{post=}
/route/system_routes                               : @{get=}
/rsyncd                                            : @{get=; put=}
/rsyncmod                                          : @{get=; post=}
/rsyncmod/id/{id}                                  : @{delete=; get=; put=}
/rsynctask                                         : @{get=; post=}
/rsynctask/id/{id}                                 : @{delete=; get=; put=}
/rsynctask/id/{id}/run                             : @{post=}
/s3                                                : @{get=; put=}
/s3/bindip_choices                                 : @{get=}
/sensor/query                                      : @{get=}
/service                                           : @{get=}
/service/id/{id}                                   : @{get=; put=}
/service/reload                                    : @{post=}
/service/restart                                   : @{post=}
/service/start                                     : @{post=}
/service/started                                   : @{get=}
/service/stop                                      : @{post=}
/service/terminate_process                         : @{post=}
/sharing/afp                                       : @{get=; post=}
/sharing/afp/id/{id}                               : @{delete=; get=; put=}
/sharing/nfs                                       : @{get=; post=}
/sharing/nfs/id/{id}                               : @{delete=; get=; put=}
/sharing/nfs/human_identifier                      : @{get=}
/sharing/smb                                       : @{get=; post=}
/sharing/smb/id/{id}                               : @{delete=; get=; put=}
/sharing/smb/presets                               : @{get=}
/sharing/webdav                                    : @{get=; post=}
/sharing/webdav/id/{id}                            : @{delete=; get=; put=}
/smart                                             : @{get=; put=}
/smart/test                                        : @{get=; post=}
/smart/test/id/{id}                                : @{delete=; get=; put=}
/smart/test/disk_choices                           : @{post=}
/smart/test/manual_test                            : @{post=}
/smart/test/results                                : @{get=}
/smb                                               : @{get=; put=}
/smb/bindip_choices                                : @{get=}
/smb/domain_choices                                : @{get=}
/smb/get_remote_acl                                : @{post=}
/smb/groupmap_addmem                               : @{get=}
/smb/groupmap_listmem                              : @{get=}
/smb/json_check_version                            : @{get=}
/smb/status                                        : @{post=}
/smb/unixcharset_choices                           : @{get=}
/smb/update_payload_with_diff                      : @{get=}
/smb/sharesec                                      : @{get=; post=}
/smb/sharesec/id/{id}                              : @{delete=; get=; put=}
/smb/sharesec/getacl                               : @{post=}
/smb/sharesec/synchronize_acls                     : @{get=}
/snmp                                              : @{get=; put=}
/ssh                                               : @{get=; put=}
/ssh/bindiface_choices                             : @{get=}
/staticroute                                       : @{get=; post=}
/staticroute/id/{id}                               : @{delete=; get=; put=}
/stats/get_data                                    : @{post=}
/stats/get_dataset_info                            : @{post=}
/stats/get_sources                                 : @{get=}
/support                                           : @{get=; put=}
/support/fetch_categories                          : @{post=}
/support/fields                                    : @{get=}
/support/is_available                              : @{get=}
/support/is_available_and_enabled                  : @{get=}
/support/new_ticket                                : @{post=}
/system/boot_id                                    : @{get=}
/system/environment                                : @{get=}
/system/feature_enabled                            : @{post=}
/system/host_id                                    : @{get=}
/system/info                                       : @{get=}
/system/is_freenas                                 : @{get=}
/system/license_update                             : @{post=}
/system/product_name                               : @{get=}
/system/product_type                               : @{get=}
/system/ready                                      : @{get=}
/system/reboot                                     : @{post=}
/system/shutdown                                   : @{post=}
/system/state                                      : @{get=}
/system/version                                    : @{get=}
/system/advanced                                   : @{get=; put=}
/system/advanced/sed_global_password               : @{get=}
/system/advanced/serial_port_choices               : @{get=}
/system/general                                    : @{get=; put=}
/system/general/country_choices                    : @{get=}
/system/general/kbdmap_choices                     : @{get=}
/system/general/language_choices                   : @{get=}
/system/general/local_url                          : @{get=}
/system/general/timezone_choices                   : @{get=}
/system/general/ui_address_choices                 : @{get=}
/system/general/ui_certificate_choices             : @{get=}
/system/general/ui_httpsprotocols_choices          : @{get=}
/system/general/ui_restart                         : @{get=; post=}
/system/general/ui_v6address_choices               : @{get=}
/system/ntpserver                                  : @{get=; post=}
/system/ntpserver/id/{id}                          : @{delete=; get=; put=}
/system/ntpserver/test_ntp_server                  : @{get=}
/systemdataset                                     : @{get=; put=}
/tftp                                              : @{get=; put=}
/truecommand                                       : @{get=; put=}
/truenas/accept_eula                               : @{get=}
/truenas/get_chassis_hardware                      : @{get=}
/truenas/get_customer_information                  : @{get=}
/truenas/get_eula                                  : @{get=}
/truenas/is_eula_accepted                          : @{get=}
/truenas/is_production                             : @{get=}
/truenas/set_production                            : @{post=}
/truenas/update_customer_information               : @{post=}
/tunable                                           : @{get=; post=}
/tunable/id/{id}                                   : @{delete=; get=; put=}
/tunable/tunable_type_choices                      : @{get=}
/update/check_available                            : @{post=}
/update/download                                   : @{get=}
/update/get_auto_download                          : @{get=}
/update/get_pending                                : @{post=}
/update/get_trains                                 : @{get=}
/update/manual                                     : @{post=}
/update/set_auto_download                          : @{post=}
/update/set_train                                  : @{post=}
/update/update                                     : @{post=}
/ups                                               : @{get=; put=}
/ups/driver_choices                                : @{get=}
/ups/port_choices                                  : @{get=}
/user                                              : @{get=; post=}
/user/id/{id}                                      : @{delete=; get=; put=}
/user/get_next_uid                                 : @{get=}
/user/get_user_obj                                 : @{post=}
/user/has_root_password                            : @{get=}
/user/id/{id}/pop_attribute                        : @{post=}
/user/id/{id}/set_attribute                        : @{post=}
/user/shell_choices                                : @{post=}
/vm                                                : @{get=; post=}
/vm/id/{id}                                        : @{delete=; get=; put=}
/vm/id/{id}/clone                                  : @{post=}
/vm/flags                                          : @{get=}
/vm/get_attached_iface                             : @{post=}
/vm/get_available_memory                           : @{post=}
/vm/get_console                                    : @{post=}
/vm/get_vmemory_in_use                             : @{get=}
/vm/get_vnc                                        : @{post=}
/vm/get_vnc_ipv4                                   : @{get=}
/vm/identify_hypervisor                            : @{get=}
/vm/id/{id}/poweroff                               : @{post=}
/vm/random_mac                                     : @{get=}
/vm/id/{id}/restart                                : @{post=}
/vm/id/{id}/start                                  : @{post=}
/vm/id/{id}/status                                 : @{post=}
/vm/id/{id}/stop                                   : @{post=}
/vm/vnc_port_wizard                                : @{get=}
/vm/device                                         : @{get=; post=}
/vm/device/id/{id}                                 : @{delete=; get=; put=}
/vm/device/nic_attach_choices                      : @{get=}
/vm/device/pptdev_choices                          : @{get=}
/vm/device/vnc_bind_choices                        : @{get=}
/vmware                                            : @{get=; post=}
/vmware/id/{id}                                    : @{delete=; get=; put=}
/vmware/dataset_has_vms                            : @{post=}
/vmware/get_datastores                             : @{post=}
/vmware/get_virtual_machines                       : @{post=}
/vmware/match_datastores_with_datasets             : @{post=}
/webdav                                            : @{get=; put=}
/webui/image                                       : @{get=}
/webui/image/id/{id}                               : @{delete=; get=}
/zfs/snapshot                                      : @{get=; post=}
/zfs/snapshot/id/{id}                              : @{delete=; get=}
/zfs/snapshot/clone                                : @{post=}
/zfs/snapshot/remove                               : @{post=}
/zfs/snapshot/rollback                             : @{post=}
```