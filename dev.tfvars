#### Environment
environment = "dev"
tags = {
  app = "putux"
}

#### Cluster Configuration
cluster_name    = "eks-putux"
cluster_version = "1.15"
cluster_enabled_log_types = [
  "audit",
  "authenticator",
  "scheduler"
]
cluster_log_kms_key_id        = ""
cluster_log_retention_in_days = 90
# cluster_create_timeout        = "15m"
# cluster_delete_timeout        = "15m"
# wait_for_cluster_cmd          = "timeout 5m bash -c 'until curl -k -s $ENDPOINT/healthz >/dev/null; do sleep 4; done'"
vpc_type = "Blue"
# vpc_id = ""
# subnet_ids = []
subnets_include_cn_dtag = true
subnets_include_private = false
proxy_address           = "fpa-shared-non-prod.aws.telekom.de:3128"

#### API Access
cluster_endpoint_private_access = true
cluster_endpoint_private_access_cidrs = [
  "10.0.0.0/8",
  "100.64.0.0/16"
]
cluster_endpoint_public_access = false
cluster_endpoint_public_access_cidrs = []
kubectl_base_config = {
  # config_map_1 = {
  #   template = "templates/test-config-map.yaml.tpl"
  #   vars = {
  #     name = "test1"
  #     KEY1 = "VALUE1"
  #   }
  # }
  # config_map_2 = {
  #   template = "templates/test-config-map.yaml.tpl"
  #   vars = {
  #     name = "test2"
  #     KEY1 = "VALUE1"
  #   }
  # }
}
# helm_repositories = {
#   bitnami = {
#     url = "https://charts.bitnami.com/bitnami"
#   }
# }

# helm_releases = {
#   nginx-test = {
#     repository           = "bitnami"
#     chart                = "nginx"
#     version              = ""
#     values               = []
#     namespace            = "default"
#     repository_key_file  = ""
#     repository_cert_file = ""
#     repository_ca_file   = ""
#     repository_username  = ""
#     repository_password  = ""
#     timeout              = 300
#     disable_webhooks     = false
#     reuse_values         = false
#     reset_values         = false
#     force_update         = false
#     recreate_pods        = false
#     cleanup_on_fail      = false
#     wait                 = true
#     sets                 = []
#     set_sensatives       = []
#     set_strings = [
#       {
#         name  = "service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-internal"
#         value = "true"
#       }
#     ]
#   }
# }

ingress_controller_alb   = false
ingress_controller_nginx = true

# pod_roles = {
#   TestRole1 = {
#     rolename = "TestRole1"
#     namespace            = "default"
#     service_account_name = "serviceaccounthere"
#     permissions_boundary = null
#     path                 = "/"
#     tags                 = {}
#     inline_policies = {
#       allow_s3 = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": [
#         "s3:GetObject"
#       ],
#       "Resource": [
#         "arn:aws:s3:::my-pod-secrets-bucket/*"
#       ]
#     }
#   ]
# }
# EOF
#     }
#     managed_policies = [
#       "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#     ]
#   }
# }

#### Authentication
manage_aws_auth = true
enable_irsa     = true

#### Kube Config
write_kubeconfig = false
# config_output_path                           = "./"
# kubeconfig_aws_authenticator_command         = "aws-iam-authenticator"
# kubeconfig_aws_authenticator_command_args    = []
# kubeconfig_aws_authenticator_additional_args = []
# kubeconfig_aws_authenticator_env_variables   = {}
# kubeconfig_name                              = ""

#### IAM Configuration
# permissions_boundary     = null
# iam_path                 = "/"
attach_worker_cni_policy = true
# map_accounts             = []
map_roles = [
  {
    rolearn  = "arn:aws:iam::954964234246:role/ADFS_DTIT_Project_Admin"
    username = "ADFS_DTIT_Project_Admin"
    groups   = ["system:masters"]
  }
]
# map_users                = []
