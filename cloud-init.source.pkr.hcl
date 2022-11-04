source "file" "meta_data" {
  source = "${path.root}/templates/meta-data.pkrtpl"
  target = "${path.root}/http/meta-data"
}

source "file" "user_data" {
  content = templatefile("${path.root}/templates/user-data.pkrtpl", {
    locale                  = "en_GB"
    timezone                = "Europe/Dublin"
    keyboard_layout         = "en"
    keyboard_varient        = "uk"
    ssh_username            = var.ssh_username
    ssh_password            = bcrypt(var.ssh_password)
    ssh_public_keys         = compact(var.ssh_public_key)
  })
  target = "${path.root}/http/user-data"
}