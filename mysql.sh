source common.sh
app_name=mysql

print_heading "Install MySQL server"
dnf install mysql-server -y &>>$log_file
status_check $?

print_heading "Start MySQL service"
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
status_check $?

print_heading "Setup MySQL Password"
mysql_secure_installation --set-root-pass RoboShop@1 &>>$log_file
status_check $?