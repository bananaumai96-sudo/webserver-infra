# WebServer Infra - AWS Portfolio

**AWS 上で Webサーバー構築・インフラ自動化** リポジトリです（2026/2/8現在　作成中）

---

## 目次
- [概要](#概要)
- [設計ポイント](#設計ポイント)
- [使用技術](#使用技術)
- [構成図](#構成図)
- [セットアップ](#セットアップ)
- [ディレクトリ構成](#ディレクトリ構成)

---

## 概要
このプロジェクトでは以下を目的にAWS上でインフラを構築しています：
- 可用性とセキュリティを意識した設計・構築を実施
- コストについてはユースケースやトレードオフによると考えているため基礎的な設計を実施
- IaC（Infrastructure as Code）で再現可能な環境構築
- 本構成は、CloudFront + ALB + Auto Scaling EC2 を中心とした高可用・セキュアなWebサーバー構成です。
---

## 設計ポイント
- EC2はPrivate Subnetに配置し、CloudFront経由でのみアクセス可能とすることでセキュリティを向上
- NAT GatewayをAZごとに配置し、単一AZ障害時でもPrivate Subnetからのアウトバウンド通信を維持
- CloudFrontにWAFを設定する事によりセキュリティ対策を実施
- WAFはAWSManagedRulesCommonRuleでSQLインジェクション、クロスサイトスクリプティング等の一般的なWEB攻撃を対策
- RateLimitを設定しDDOS攻撃を対策
- EC2に接続する場合はセッションマネージャーを使用
- 障害時解析用にCloudFrontとALBのアクセスログをs3に保管
- スケールアウト・スケールイン失敗時に検知出来るようにメールを送信できるようSNSを実装
- Terraformの基本的なリソース定義や依存関係の理解を優先し、modulesは単一構成で実装し、将来的な再利用を考慮し、リソースごとにファイルを分割している
---

## 使用技術
- **AWS**
- **Terraform**
- **Git / GitHub**
---

## 構成図

![構成図](docs/architecture.png)
---

## セットアップ
### 事前準備
- AWS アカウント
- AWS CLIインストール
- Terraformインストール

### 設定
- IAMユーザー作成(sts:AssumeRoleとiam*権限を許可し、terraform-bootstrapで作成するロールのarnをリソース指定したポリシーを付与)
- 上記IAMユーザーのアクセスキー作成
- AWS CLIでprofile作成（baseとterraform）
- baseプロファイルに上記で作成したIAMユーザーのアクセスキーとシークレットキーを設定
- terrafomrプロファイルにアクセスキーとシークレットキーは不要
- terraformプロファイルにterraform-bootstrapで作成するロールを設定
- terraformプロファイルにbaseプロファイルをソース指定
- terraform-bootstrap/は初回のみ実行のため実行後はiam*権限を削除推奨


## 作業用ディレクトリで実施
### 初期化
terraform init

### 確認
terraform plan

### デプロイ
terraform apply

# ディレクトリ構成
```
webserver-infra/
├─ README.md
├─ .gitignore                               # GitHubに不要ファイル排除用
├─ terraform/                               # webserver-infra作成用（作業用ディレクトリ）
│   ├─ backend.tf                           # .tfstate保管用
│   ├─ network.tf   　                      # modules/network作成用
│   ├─ alb.tf   　                          # alb作成用
│   ├─ alb_listener.tf                      # albリスナー作成用
│   ├─ tg.tf   　                           # ターゲットグループ作成用
│   ├─ asg.tf   　                          # Auto Scalingグループ作成用
│   ├─ asg_policy.tf   　                   # Auto Scalingポリシー作成用
│   ├─ launch_template.tf                   # 起動テンプレート作成用
│   ├─ asg_notification.tf                  # オートスケール失敗時通知用SNS作成用
│   ├─ s3_acl.tf                            # CloudFront用s3_ACL作成用
│   ├─ s3_bucket.tf                         # s3バケット作成用
│   ├─ s3_encryption.tf                     # s3バケット暗号化用
│   ├─ s3_lifecycle.tf                      # s3バケットライフサイクル作成用
│   ├─ s3_policy.tf                         # s3バケットポリシー作成用
│   ├─ s3_public_access_block.tf            # s3バケット_public_access_block作成用
│   ├─ asg_sns.tf                           # ASG用SNS作成用
│   ├─ cloudtrail_alarm.tf                  # cloudtrailアラーム作成用
│   ├─ cloudtrail_iam_role.tf               # cloudtrail用ロールにIAMポリシー適用
│   ├─ cloudtrail_role.tf                   # cloudtrail用ロール作成用
│   ├─ cloudtrail_sns.tf                    # cloudtrail用SNS作成用
│   ├─ cloudwatch_log_group.tf              # cloudtrail用cloudwatch_log_grou作成用
│   ├─ cloudwatch_log_metric_filter.tf      # cloudtrail用metric_filter作成用
│   ├─ waf.tf                               # WAF(Web-Acl)作成用
│   ├─ rds.tf                               # RDS作成用
│   ├─ rds_sg.tf                            # RDSサブネットグループ作成用
│   ├─ rds_pg.tf                            # RDSパラメーターグループ作成用
│   ├─ data.tf                              # 作成リソースの情報取得用
│   ├─ providers.tf                         # リージョン用
│   ├─ variables.tf                         # 変数定義
│   ├─ terraform.tfvars                     # 変数値ファイル
│   ├─ terraform.tfvars.example　           # 変数値ファイル設定例
│   ├─ locals.tf                            # 共通タグ用
│   ├─ .terraform.lock.hcl
│   └─ modules/                             #modules
│  　     └─network/                        #基盤部分作成用
│            ├─igw.tf                       # インターネットゲートウェイ作成用
│            ├─nat.tf                       # NATゲートウェイ作成用
│            ├─output.tf                    # root_module出力用
│            ├─route_table.tf               # ルートテーブル作成用
│            ├─sg.tf                        # セキュリティゲートウェイ作成用
│            ├─subnet.tf                    # サブネット作成用
│            ├─variables.tf                 # 変数定義
│            └─vpc.tf                       # VPC作成用
├─ docs/
│  　└─architecture.png 　                  # 構成図
└─ terraform-bootstrap/                     # 初回のみ実行するTerraform用IAMロール作成用（作業用ディレクトリ）
             ├─attachment.tf                # ポリシーをロールにアタッチ用
             ├─locals.tf                    # 共通設定用
             ├─policy_terraform.tf          # ポリシー作成用
             ├─policy_terraform_network.tf  # ポリシー作成用
             ├─provider.tf                  # リージョン用
             ├─role.tf                      # ロール作成用
             ├─variables.tf                 # 変数値ファイル
             └─terraform.tfvars.example     # 変数値ファイル設定例
```
