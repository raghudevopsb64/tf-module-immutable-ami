resource "null_resource" "app-deploy" {
  triggers = {
    ABC = timestamp()
  }
  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["SSH_USERNAME"]
      password = jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["SSH_PASSWORD"]
      host     = aws_spot_instance_request.spot.private_ip
    }

    inline = [
      "ansible-pull -U https://github.com/raghudevopsb64/roboshop-ansible.git roboshop.yml -e HOST=localhost -e ROLE_NAME=${var.COMPONENT} -e ENV=ENV -e DBTYPE=DOCUMENTDB -e DOCDB_ENDPOINT=DOCDB_ENDPOINT -e APP_VERSION=${var.APP_VERSION}"
    ]
  }
}


