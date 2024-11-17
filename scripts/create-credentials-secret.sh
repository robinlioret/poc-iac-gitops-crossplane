
DIR_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
cd "$DIR_ROOT" || exit 1

kubectl create secret generic -n crossplane-system aws-iac-secret --from-file=credentials=./sensitive/aws-credentials