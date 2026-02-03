# WebServer Infra - AWS Portfolio

ポートフォリオ用に作成した **AWS 上での Web サーバー構築・インフラ自動化** リポジトリです（2026/2/3現在　作成中）

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
- 設計・構築がメイン
- IaC（Infrastructure as Code）で再現可能な環境構築

---

## 設計ポイント
- EC2はPrivate Subnetに配置し、ALB経由でのみアクセス可能とすることでセキュリティを向上
- NAT GatewayをAZごとに配置し、可用性を考慮
- CloudFront + WAFによりエッジレイヤーでのセキュリティ対策を実施
- EC2に接続する場合はセッションマネージャーを使用
- Terraformの基本的なリソース定義や依存関係の理解を優先し、modulesは単一構成で実装している。ただし、将来的な再利用を考慮し、責務ごとにファイルを分割している

---

## 使用技術
- **AWS**：EC2, S3, VPC, Security Group, CloudFront, AWS WAF, ALB, Auto Scaling Group, CloudWatch（Logs / Alarm）, NAT Gateway, SNS, AWS Sheld
- **Terraform**：IaC用
- **Git / GitHub**：ソース管理

---

## 構成図
この構成は、AWS上にWebサーバーをマルチAZ配置にし、ALBで負荷分散を行い
Auto Scaling Groupを使用することで可用性かつスケーラブルな構築にしています。
また、CloudFrontやWAFでセキュリティを強化した構成です。
CPU平均使用率が閾値を超えた場合、メールを送信して検知できるようにしています。

[構成図](docs/architecture.png)

---

## セットアップ
### 前提条件
- AWS アカウント
- CloudshellにTerraformインストール

# 初期化
terraform init

# 計画の確認
terraform plan

# デプロイ
terraform apply

# ディレクトリ構成
```
webserver-infra/
├─ README.md
├─ .gitignore                     # GitHubに不要ファイル排除用
├─ terraform/                     # Terraform構成
│   ├─ backend.tf                 # .tfstate保管用
│   ├─ network.tf   　            # network作成用
│   ├─ alb.tf   　                # alb作成用
│   ├─ alb_listener.tf            # albリスナー作成用
│   ├─ tg.tf   　                 # ターゲットグループ作成用
│   ├─ asg.tf   　                # Auto Scalingグループ作成用
│   ├─ asg_policy.tf   　         # Auto Scalingポリシー作成用
│   ├─ launch_template.tf         # 起動テンプレート作成用
│   ├─ providers.tf 　            # リージョン用
│   ├─ variables.tf 　            # 変数定義
│   ├─ terraform.tfvars           # 変数値ファイル
│   ├─ terraform.tfvars.example　 # 変数値ファイル設定例
│   ├─ locals.tf                  # 共通タグ用
│   ├─ .terraform.lock.hcl
│   └─ modules/                   #modules用
│  　     └─network/              #基盤部分作成用
│            ├─igw.tf             # インターネットゲートウェイ
│            ├─nat.tf             # NATゲートウェイ
│            ├─output.tf          # root_module出力用
│            ├─route_table.tf     # ルートテーブル
│            ├─sg.tf              # セキュリティゲートウェイ
│            ├─subnet.tf          # サブネット
│            ├─variables.tf       # 変数定義
│            └─vpc.tf             # VPC
├─ docs/
│  　└─architecture.png 　          # 構成図
└─ terraform-boosttrap/            # terraform構築権限用
```
