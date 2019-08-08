workflow "Test" {
  on = "push"
  resolves = ["new-action"]
}

action "Setup Ruby for use with actions" {
  uses = "actions/setup-ruby@348966bbc4a99fb09f8e302ca4cd8a5f89c2627f"
}

action "new-action" {
  uses = "owner/repo/path@ref"
  needs = ["Setup Ruby for use with actions"]
}
