#############
## General ##
#############
variable "environment" {
  description = "Name of this AWS environment (either Dev, Test, UAT or Prod). Used for naming resources"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

###########################
## Cluster Configuration ##
###########################
variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster."
  type        = string
  default     = "1.14"
}

variable "cluster_enabled_log_types" {
  default     = []
  description = "A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
  type        = list(string)
}

variable "cluster_log_kms_key_id" {
  default     = ""
  description = "If a KMS Key ARN is set, this key will be used to encrypt the corresponding log group. Please be sure that the KMS Key has an appropriate key policy (https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/encrypt-log-data-kms.html)"
  type        = string
}

variable "cluster_log_retention_in_days" {
  default     = 90
  description = "Number of days to retain log events. Default retention - 90 days."
  type        = number
}

variable "cluster_create_timeout" {
  description = "Timeout value when creating the EKS cluster."
  type        = string
  default     = "15m"
}

variable "cluster_delete_timeout" {
  description = "Timeout value when deleting the EKS cluster."
  type        = string
  default     = "15m"
}

variable "wait_for_cluster_cmd" {
  description = "Custom local-exec command to execute for determining if the eks cluster is healthy. Cluster endpoint will be available as an environment variable called ENDPOINT"
  type        = string
  default     = "timeout 5m bash -c 'until curl -k -s $ENDPOINT/healthz >/dev/null; do sleep 4; done'"
}

variable "proxy_address" {
  description = "Proxy URL to be used for the environment. If specified it configures relevant aws-node DaemonSet and configmap. If left empty no proxy configuration will be created."
  type        = string
  default     = ""
}

variable "vpc_type" {
  description = "Type of the VPC to be used to deploy EKS cluster. Used to find the relevant VPC id and subnets."
  type        = string
}

variable "vpc_id" {
  description = "The Vpc Id to launch the EKS Worker Nodes. If not specified it will automatically be determined by using the values specified in 'environment' and 'vpc_type'."
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "List of subnets to launch the EKS Worker Nodes. If not specified then the subnets are found dynamically using the values from the following variables: 'subnets_include_cn_dtag' and 'subnets_include_private'"
  type        = list(string)
  default     = []
}

variable "subnets_include_cn_dtag" {
  description = "Whether the EKS cluster should be launched within the cn-dtag subnets (can also be combined with subnets_include_private). Default value is 'true'"
  type        = bool
  default     = true
}

variable "subnets_include_private" {
  description = "Whether the EKS cluster should be launched within the private subnets (can also be combined with subnets_include_cn_dtag). Default value is 'false'"
  type        = bool
  default     = false
}

variable "kubectl_base_config" {
  description = "A hashmap that specifies additional Kubernetes YAML config (and vars to interpolate) to be created with kubectl apply commands."
  default     = {}
  type = map(object({
    template = string
    vars     = map(string)
  }))
}

variable "helm_repositories" {
  description = "A chart repository is a location where packaged charts can be stored and shared."
  default     = {}
  type = map(object({
    url = string
  }))
}

variable "helm_releases" {
  description = "A Release is an instance of a chart running in a Kubernetes cluster. A Chart is a Helm package. It contains all of the resource definitions necessary to run an application, tool, or service inside of a Kubernetes cluster."
  default     = {}
  type = map(object({
    repository           = string
    chart                = string
    version              = string
    values               = list(string)
    namespace            = string
    repository_key_file  = string
    repository_cert_file = string
    repository_ca_file   = string
    repository_username  = string
    repository_password  = string
    timeout              = number
    disable_webhooks     = bool
    reuse_values         = bool
    reset_values         = bool
    force_update         = bool
    recreate_pods        = bool
    cleanup_on_fail      = bool
    wait                 = bool
    sets = list(object({
      name  = string
      value = string
    }))
    set_sensatives = list(object({
      name  = string
      value = string
    }))
    set_strings = list(object({
      name  = string
      value = string
    }))

  }))
}

variable "ingress_controller_alb" {
  description = "Whether to pre-install ALB ingress controller upon cluster creation."
  type        = bool
  default     = false
}

variable "ingress_controller_nginx" {
  description = "Whether to pre-install NGINX ingress controller upon cluster creation."
  type        = bool
  default     = false
}

variable "pod_roles" {
  description = "Custom roles to create for pod service accounts"
  default     = {}
  type = map(object({
    rolename             = string
    namespace            = string
    service_account_name = string
    permissions_boundary = string
    path                 = string
    tags                 = map(string)
    inline_policies      = map(string)
    managed_policies     = list(string)
  }))
}

################
## API Access ##
################

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type        = bool
  default     = false
}

variable "cluster_endpoint_private_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS private API server endpoint on port 443."
  type        = list(string)
  default = [
    "0.0.0.0/0"
  ]
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled."
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
  type        = list(string)
  default     = []
}


################
## API Access ##
################
variable "enable_irsa" {
  description = "Whether to create OpenID Connect Provider for EKS to enable IRSA"
  type        = bool
}

variable "eks_oidc_root_ca_thumbprint" {
  type        = string
  description = "Thumbprint of Root CA for EKS OIDC, Valid until 2037"
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}

variable "manage_aws_auth" {
  description = "Whether to apply the aws-auth configmap file."
  type        = bool
}

#################
## Kube Config ##
#################

variable "config_output_path" {
  description = "Where to save the Kubectl config file (if `write_kubeconfig = true`). Assumed to be a directory if the value ends with a forward slash `/`."
  type        = string
  default     = "./"
}

variable "write_kubeconfig" {
  description = "Whether to write a Kubectl config file containing the cluster configuration. Saved to `config_output_path`."
  type        = bool
  default     = true
}

variable "kubeconfig_aws_authenticator_command" {
  description = "Command to use to fetch AWS EKS credentials."
  type        = string
  default     = "aws-iam-authenticator"
}

variable "kubeconfig_aws_authenticator_command_args" {
  description = "Default arguments passed to the authenticator command. Defaults to [token -i $cluster_name]."
  type        = list(string)
  default     = []
}

variable "kubeconfig_aws_authenticator_additional_args" {
  description = "Any additional arguments to pass to the authenticator such as the role to assume. e.g. [\"-r\", \"MyEksRole\"]."
  type        = list(string)
  default     = []
}

variable "kubeconfig_aws_authenticator_env_variables" {
  description = "Environment variables that should be used when executing the authenticator. e.g. { AWS_PROFILE = \"eks\"}."
  type        = map(string)
  default     = {}
}

variable "kubeconfig_name" {
  description = "Override the default name used for items kubeconfig."
  type        = string
  default     = ""
}

#######################
## IAM Configuration ##
#######################

variable "permissions_boundary" {
  description = "If provided, all IAM roles will be created with this permissions boundary attached."
  type        = string
  default     = null
}

variable "iam_path" {
  description = "If provided, all IAM roles will be created on this path."
  type        = string
  default     = "/"
}

variable "attach_worker_cni_policy" {
  description = "Whether to attach the Amazon managed `AmazonEKS_CNI_Policy` IAM policy to the default worker IAM role. WARNING: If set `false` the permissions must be assigned to the `aws-node` DaemonSet pods via another method or nodes will not be able to join the cluster."
  type        = bool
  default     = true
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)

  default = []
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = []

  # default = [
  #   {
  #     rolearn  = "arn:aws:iam::66666666666:role/role1"
  #     username = "role1"
  #     groups   = ["system:masters"]
  #   },
  # ]
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = []

  # default = [
  #   {
  #     userarn  = "arn:aws:iam::66666666666:user/user1"
  #     username = "user1"
  #     groups   = ["system:masters"]
  #   },
  #   {
  #     userarn  = "arn:aws:iam::66666666666:user/user2"
  #     username = "user2"
  #     groups   = ["system:masters"]
  #   },
  # ]
}
