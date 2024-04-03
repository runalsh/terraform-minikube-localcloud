data "terracurl_request" "test" {
  name   = "check"
  url    = "http://gitlab.${var.local_domain}"
  method = "GET"
  skip_tls_verify = true
  response_codes = [200]
  count = var.terracurl_request ? 1 : 0  
  
  max_retry      = 3
  retry_interval = 5
}