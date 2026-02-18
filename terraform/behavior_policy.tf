# --- CloudFrontが情報をキャッシュする時のポリシー ---
# Cache-Control なし：1日キャッシュ保持
# Cache-Control MAX：1年キャッシュ保持
# Cookie(ログイン状態等)：なし
# Header(多言語等):なし
# Query(API等)：なし 
resource "aws_cloudfront_cache_policy" "static" {
  name = "static-cache-policy"

  default_ttl = 86400
  max_ttl     = 31536000
  min_ttl     = 0

  parameters_in_cache_key_and_forwarded_to_origin {

    cookies_config {
      cookie_behavior = "none"
    }

    headers_config {
      header_behavior = "none"
    }

    query_strings_config {
      query_string_behavior = "none"
    }
    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip   = true
  }
}

# --- CloudFrontがオリジンへ送る情報を制御する時のポリシー ---
# Cookie(ログイン状態等)：なし
# Header(多言語等):HOST
# Query(API等)：なし 
resource "aws_cloudfront_origin_request_policy" "static" {
  name = "static-origin-policy"

  cookies_config {
    cookie_behavior = "none"
  }

  headers_config {
    header_behavior = "whitelist"
    headers {
      items = ["host"]
    }
  }

  query_strings_config {
    query_string_behavior = "none"
  }
}

# --- CloudFrontがブラウザへ返すレスポンスのセキュリティヘッダポリシー設定 ---
# ブラウザの「MIMEタイプ推測」を禁止
# 他サイトの iframe 内表示を禁止
# 外部サイトへ送るリファラー情報制限
# HSTS
# ブラウザのXSSフィルタ有効化
resource "aws_cloudfront_response_headers_policy" "security" {
  name = "security-headers"

  security_headers_config {

    content_type_options {
      override = true
    }

    frame_options {
      frame_option = "DENY"
      override     = true
    }

    referrer_policy {
      referrer_policy = "same-origin"
      override        = true
    }

    strict_transport_security {
      access_control_max_age_sec = 63072000
      include_subdomains         = true
      preload                    = true
      override                   = true
    }

    xss_protection {
      protection = true
      mode_block = true
      override   = true
    }
  }
}
