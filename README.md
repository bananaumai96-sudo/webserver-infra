# WebServer Infra - AWS Portfolio

**AWS 上で Webサーバー構築・インフラ自動化** リポジトリです

---

## 目次
- [概要](#概要)
- [設計ポイント](#設計ポイント)
- [制約事項](#制約事項)
- [使用技術](#使用技術)
- [構成図](#構成図)
- [セットアップ](#セットアップ)
- [Terraform認証構成](#Terraform認証構成)
- [ディレクトリ構成](#ディレクトリ構成)

---

## 概要
このプロジェクトでは以下を目的にAWS上でインフラを構築しています：
- 可用性、セキュリティ、運用を意識した設計・構築を実施
- コストについてはユースケースやトレードオフによるものと考えているため基礎的な設計を実施
- IaC（Infrastructure as Code）で再現可能な環境構築

---

## 設計ポイント
- EC2のセキュリティグループはALBからの通信のみ許可し、ALBはCloudFrontからの通信のみに制限することで、オリジンへの直接アクセスを防止しセキュリティを向上
- AWS WAFを利用し、SQLインジェクションやクロスサイトスクリプティング等の一般的なWEB攻撃を対策
- レート制限を設定しDDOS攻撃を対策
- ユーザー〜CloudFront〜ALB間をHTTPS通信とし、通信の暗号化とデータ保護を実現
- NAT Gatewayを各AZに配置し、単一AZ障害時でもPrivate Subnetからのアウトバウンド通信を維持
- EC2への運用アクセスはAWS SystemsManagerSessionManagerを利用し、踏み台サーバ不要の安全な接続を実現
- Auto Scalingのスケールアウト/スケールイン失敗時にAmazon SNSで通知し、障害検知を可能にする
- 障害解析および監査対応のため、ログをS3およびCloudWatch Logsに転送
- AWS Backupを利用し、タグベースの自動バックアップを実施
- Terraformはリソース定義と依存関係の理解を優先し、モジュールは単一構成で実装。将来的な再利用を見据え、リソース単位でファイルを分割

---

## 制約事項
### Free Tierアカウント制限による影響
- **RDS**
  - Multi-AZ構成が利用不可
  - 本番ではMulti-AZ構成を採用予定

- **認証・アクセス管理**
  - Organizationsが利用できないためSSOによるterraform運用未対応
  - 本番ではSSO＋IAM Roleによる安全な運用を想定

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

---

## Terraform認証構成
- IAMユーザーを作成し、以下を付与
  - sts:AssumeRole（terraform-bootstrap ロール引受用）
  - IAM管理権限（bootstrap時のみ）
- アクセスキーを作成

- AWS CLI プロファイル設定
  - base: アクセスキー設定
  - terraform:
    - role_arn = terraform-bootstrap ロール
    - source_profile = base

- bootstrap実行後はIAM作成権限の削除を推奨
- ACM証明書作成にはドメインが必要

---

## 作業用ディレクトリで実施
### 初期化
terraform init

### 確認
terraform plan

### デプロイ
terraform apply

---

# ディレクトリ構成
```
webserver-infra/
├─ README.md
├─ .gitignore                               # Gitの除外リスト
│
├─ docs/                                    # ドキュメントフォルダ
│  └─architecture.png                       # 構成図
│
├─ terraform/                               # webserver-infra作成用（作業用ディレクトリ）
│   ├─ .terraform.lock.hcl                  # プロバイダー固定ファイル
│   ├─ acm_validation.tf                    # 証明書検証用
│   ├─ acm.tf                               # 証明書リクエスト用
│   ├─ alb_listener.tf                      # ALB用リスナー 作成用
│   ├─ alb_tg.tf                            # ターゲットグループ 作成用
│   ├─ alb.tf                               # ALB 作成用
│   ├─ asg_notification.tf                  # Auto Scaling Group SNS作成用
│   ├─ asg_policy.tf                        # Auto Scaling Group ポリシー作成用
│   ├─ asg_sns.tf                           # Auto Scaling Group SNS作成用
│   ├─ asg.tf                               # Auto Scaling Group 作成用
│   ├─ backend.tf                           # .tfstate保管用
│   ├─ backup_plan.tf                       # AWS Backup プラン作成用
│   ├─ backup_role.tf                       # AWS Backup ロール作成用
│   ├─ backup_selection.tf                  # AWS Backup セレクション作成
│   ├─ backup_vault.tf                      # AWS Backup ボールト作成用
│   ├─ backup_policy.tf                     # AWS Backup Plan作成用
│   ├─ behavior_policy.tf                   # CloudFront ビヘイビア作成用
│   ├─ CloudFront.tf                        # CloudFront 作成用
│   ├─ cloudtrail_alarm.tf                  # CloudTrail アラーム作成用
│   ├─ cloudtrail_iam_role.tf               # CloudTrail ロールにポリシーアタッチ用
│   ├─ cloudtrail_role.tf                   # CloudTrail ロール作成用
│   ├─ cloudtrail_sns.tf                    # CloudTrail SNS作成用
│   ├─ cloudtrail.tf                        # CloudTrail 作成用
│   ├─ cloudwatch_log_group.tf              # CloudWatch Log Group 作成用
│   ├─ cloudwatch_log_metric_filter.tf      # CloudWatch Metric Filter 作成用
│   ├─ data.tf                              # リソース情報取得用
│   ├─ ec2_profile.tf                       # インスタンスプロファイル 作成用
│   ├─ ec2_role.tf                          # EC2 ロール作成用
│   ├─ launch_template.tf                   # 起動テンプレート 作成用
│   ├─ locals.tf                            # ローカル変数
│   ├─ network.tf                           # modules/network 作成用
│   ├─ providers.tf                         # プロバイダー定義用
│   ├─ rds_pg.tf                            # RDS パラメーターグループ 作成用
│   ├─ rds_sg.tf                            # RDS サブネットグループ 作成用
│   ├─ rds.tf                               # RDS 作成用
│   ├─ route53_host_zone.tf                 # Route53 ホストゾーン 作成用
│   ├─ route53_record.tf                    # Route53 レコード 作成用
│   ├─ s3_acl.tf                            # CloudFront用s3_ACL作成用
│   ├─ s3_bucket.tf                         # s3バケット作成用
│   ├─ s3_encryption.tf                     # s3バケット暗号化用
│   ├─ s3_lifecycle.tf                      # s3バケットライフサイクル作成用
│   ├─ s3_policy.tf                         # s3バケットポリシー作成用
│   ├─ s3_public_access_block.tf            # s3バケット_public_access_block作成用
│   ├─ terraform.tfvars.example             # 変数設定例
│   ├─ variables.tf                         # 変数用
│   ├─ waf.tf                               # WAF(Web-Acl) 作成用
│   └─ modules/                             # modules
│  　     └─ network/                       # 基盤部分作成用
│            ├─ igw.tf                      # インターネットゲートウェイ 作成用
│            ├─ nat.tf                      # NATゲートウェイ 作成用
│            ├─ output.tf                   # リソース情報出力用
│            ├─ route_table.tf              # ルートテーブル 作成用
│            ├─ sg.tf                       # セキュリティゲートウェイ 作成用
│            ├─ subnet.tf                   # サブネット 作成用
│            ├─ variables.tf                # 変数定義
│            └─ vpc.tf                      # VPC 作成用
│
└─ terraform-bootstrap/                         # 初回のみ実行するTerraform用IAMロール作成用（作業用ディレクトリ）
             ├─ .gitignore                      # Git の除外リスト
             ├─ .terraform.lock.hcl             # プロバイダー固定ファイル
             ├─ attachment.tf                   # ポリシーをロールにアタッチ用
             ├─ locals.tf                       # ローカル変数
             ├─ policy_terraform_cloudfront.tf  # ポリシー 作成用
             ├─ policy_terraform_lb.tf          # ポリシー 作成用
             ├─ policy_terraform_network.tf     # ポリシー 作成用
             ├─ policy_terraform_sv.tf          # ポリシー 作成用
             ├─ policy_terraform.tf             # ポリシー 作成用
             ├─ provider.tf                     # プロバイダー定義用
             ├─ role.tf                         # ロール 作成用
             ├─ terraform.tfvars.example        # 変数設定例
             └─ variables.tf                    # 変数用
```
