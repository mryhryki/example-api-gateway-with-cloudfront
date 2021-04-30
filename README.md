# example-api-gateway-with-cloudfront
API Gateway に対して、直接アクセスした場合と CloudFront 経由アクセスした場合に、レスポンス時間がどの様に変化するかを調査した際に使用したソースコードです。

## AWS環境の構築 (Terraform)

Terraform がインストールされていない場合は、[Terraform のインストール方法](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started) を参考にインストールしてください。


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
```

## 計測 (Deno)

Deno がインストールされていない場合は、[Deno のインストール方法](https://deno.land/#installation) を参考にインストールしてください。

```bash
$ deno run --allow-net --allow-read ./measure/index.ts
```
