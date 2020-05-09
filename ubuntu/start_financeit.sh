cd ~/code/financeit

sudo /etc/init.d/mysql start

redis-server --daemonize yes

# gem install mysql2 -v '0.3.21' -- --with-mysql-lib=/home/linuxbrew/.linuxbrew/opt/mysql@5.7/lib --with-mysql-include=/home/linuxbrew/.linuxbrew/opt/mysql@5.7/include/mysql

bundle install

# ./bin/setup


