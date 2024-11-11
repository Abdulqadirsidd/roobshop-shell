source common.sh
app_name=catalogue

nodejs_setup

print_heading "Copy Mongodb repo file"
cp $scripts_path/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>$log_file
status_check $?

print_heading "Install Mongodb Client"
dnf install mongodb-mongosh -y &>>$log_file
status_check $?

print_heading "Load Master Data"
mongosh --host mongodb.abdulqadir.shop </app/db/master-data.js
status_check $?

print_heading "Restart Catalogue Service"
systemctl restart catalogue &>>$log_file
status_check $?