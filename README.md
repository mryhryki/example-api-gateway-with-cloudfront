# example-api-gateway-with-cloudfront
API Gateway を CloudFront 経由で実行した場合のテスト

## AWS環境の構築 (Terraform)

### Setup

```bash
$ terraform init
```

### Execute

```bash
$ terraform plan
$ terraform apply
```

### Destroy

```bash
$ terraform destroy
# CloudFront 周りでエラーが出たので、AWS Console で消したほうが良いかも
```
