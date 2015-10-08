# helpful shortcuts for docker, docker-compose, docker-machine

eval "$(docker-machine env dev)"

# docker
alias d="docker"
alias dc='docker-compose'
alias dm='docker-machine'

# vagrant
alias v="vagrant"
alias vgs="vagrant global-status"

# AWS ECS
ECS_CLUSTER=default
ecs() {
  aws ecs $* --cluster $ECS_CLUSTER
}
