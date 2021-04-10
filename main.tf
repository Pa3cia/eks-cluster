terraform {
  required_version = ">= 0.12.9"
  backend "s3" {} #Uncomment to use S3 backend
}

module "eks" {
  source = "git::https://gitlab+deploy-token-7:xz6PBoWaszF684hhez5q@codeshare.workbench.telekom.de/gitlab/cloud-evangelists/ccoe-tf-aws-infra-eks-cluster.git?ref=v0.3.5"

  #General
  environment = var.environment
  tags        = var.tags
  vpc_type    = var.vpc_type

  #Cluster Config
  cluster_name                  = var.cluster_name
  cluster_version               = var.cluster_version
  cluster_enabled_log_types     = var.cluster_enabled_log_types
  cluster_log_kms_key_id        = var.cluster_log_kms_key_id
  cluster_log_retention_in_days = var.cluster_log_retention_in_days
  cluster_create_timeout        = var.cluster_create_timeout
  cluster_delete_timeout        = var.cluster_delete_timeout
  wait_for_cluster_cmd          = var.wait_for_cluster_cmd
  proxy_address                 = var.proxy_address
  vpc_id                        = var.vpc_id
  subnet_ids                    = var.subnet_ids
  subnets_include_cn_dtag       = var.subnets_include_cn_dtag
  subnets_include_private       = var.subnets_include_private
  kubectl_base_config           = var.kubectl_base_config
  helm_repositories             = var.helm_repositories
  helm_releases                 = var.helm_releases
  ingress_controller_alb        = var.ingress_controller_alb
  ingress_controller_nginx      = var.ingress_controller_nginx
  pod_roles                     = var.pod_roles

  #API Access
  cluster_endpoint_private_access       = var.cluster_endpoint_private_access
  cluster_endpoint_private_access_cidrs = var.cluster_endpoint_private_access_cidrs
  cluster_endpoint_public_access        = var.cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs  = var.cluster_endpoint_public_access_cidrs
  enable_irsa                           = var.enable_irsa
  eks_oidc_root_ca_thumbprint           = var.eks_oidc_root_ca_thumbprint
  manage_aws_auth                       = var.manage_aws_auth

  #Kube Config
  config_output_path                           = var.config_output_path
  write_kubeconfig                             = var.write_kubeconfig
  kubeconfig_aws_authenticator_command         = var.kubeconfig_aws_authenticator_command
  kubeconfig_aws_authenticator_command_args    = var.kubeconfig_aws_authenticator_command_args
  kubeconfig_aws_authenticator_additional_args = var.kubeconfig_aws_authenticator_additional_args
  kubeconfig_aws_authenticator_env_variables   = var.kubeconfig_aws_authenticator_env_variables
  kubeconfig_name                              = var.kubeconfig_name

  #IAM Config
  permissions_boundary     = var.permissions_boundary
  iam_path                 = var.iam_path
  attach_worker_cni_policy = var.attach_worker_cni_policy
  map_accounts             = var.map_accounts
  map_roles                = var.map_roles
  map_users                = var.map_users
}
