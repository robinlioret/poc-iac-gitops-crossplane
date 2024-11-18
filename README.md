# poc-iac-gitops-crossplane

An exploration of what Crossplane can do for us regarding deployment and automation.

## Run the POC

## Prerequisites

- Running on a Linux computer
- Having kind installed (see https://kind.sigs.k8s.io/docs/user/quick-start/)
- Having no entry `argocd.rli-gitops-crossplane.local` in your /etc/hosts file (it will be replaced to point to
  `127.0.0.1`)

## Notes

- The directory `sensitive` is ignored by git so it is safe to store sensitive information in it. Even if you commit to
  this repo. Make sure that you don't put credentials in the repo files.

## Procedure

1. Create AWS credentials: Access Key Id and Secret Access Key in the AWS target account.
2. Create a local file for the credentials:

```shell
mkdir sensitive
cat > sensitive/aws-credentials << EOF
[default]
aws_access_key_id = <AWS Access Key Id>
aws_secret_access_key = <AWS Secret Access Key>
EOF
```

3. In `workload/sample-s3-bucket/values.yaml`, customize your bucket name (key `resources[0].metadana.name`)
4. Create the cluster `bash scripts/create.sh`
    - This will modify your /etc/hosts file by adding / modifying the entry for `argocd.rli-gitops-crossplane.local`
5. Open your browser to `http://argocd.rli-gitops-crossplane.local` and login as `admin` with the password in the file `sensitive/argocd-password`
6. You should see your resources in ArgoCD.
7. In AWS, you should have a bucket with the name you provided in the `workload/sample-s3-bucket/values.yaml` file

## Cleanup

1. Delete the cluster `kind delete cluster`
2. Manually delete the bucket in AWS.