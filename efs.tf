resource "aws_efs_mount_target" "public1" {
  file_system_id = aws_efs_file_system.wordpress-efs.id
  subnet_id      = aws_subnet.public1.id
  security_groups = [aws_security_group.default.id]
}

resource "aws_efs_mount_target" "public2" {
  file_system_id = aws_efs_file_system.wordpress-efs.id
  subnet_id      = aws_subnet.public2.id
  security_groups =  [aws_security_group.default.id]
}

resource "aws_efs_file_system" "wordpress-efs" {
  creation_token = "my_random-wordpress-token"

  tags = {
    Name = "Wordpress-EFS"
  }
}

# DIR="/var/www/html/wp-content"
# if [ ! -d "$DIR" ]; then
#   # Take action if $DIR exists. #
#   echo "Installing wordpress ${DIR}..."
# fi