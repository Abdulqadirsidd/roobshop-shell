source common.sh
app_name=frontend

print_heading "Disable Default Nginx"
dnf module disable nginx -y &>>$log_file
status_check $?

print_heading "Enable Nginx 24 Version"
dnf module enable nginx:1.24 -y &>>$log_file
status_check $?

print_heading "Install Nginx"
dnf install nginx -y &>>$log_file
status_check $?

print_heading "Copy Nginx config file"
cp nginx.conf /etc/nginx/nginx.conf &>>$log_file
status_check $?

print_heading "Clean up old application content"
rm -rf /usr/share/nginx/html/* &>>$log_file
status_check $?

print_heading "Downloading Application content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>>$log_file
cd /usr/share/nginx/html
status_check $?

print_heading "Extract Application content"
unzip /tmp/frontend.zip &>>$log_file
status_check $?

# Install ansible

print_heading "Start Nginx"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
status_check $?

