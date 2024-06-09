parameters = [
  #{name= "test1" , value = "Hello Universe" , type = "String"},
  {name = "dev.frontend.catalogue_url", value = "http://catalogue-dev.saraldevops.site:80/" , type = "String"},
  {name = "dev.frontend.user_url", value = "http://user-dev.saraldevops.site:80/" , type = "String"},
  {name = "dev.frontend.cart_url", value = "http://cart-dev.saraldevops.site:80/" , type = "String"},
  {name = "dev.frontend.shipping_url", value = "http://shipping-dev.saraldevops.site:80/" , type = "String"},
  {name = "dev.frontend.payment_url", value = "http://payment-dev.saraldevops.site:80/" , type = "String"},
  {name = "dev.user.mongo", value = "true" , type = "String"},
  {name = "dev.user.redis_host", value = "redis-dev.saraldevops.site" , type = "String"},
  {name = "dev.user.mongo_url", value = "mongodb://mongodb-dev.saraldevops.site:27017/users" , type = "String"},
  {name = "dev.shipping.cart_endpoint", value = "cart-dev.saraldevops.site:80" , type = "String"},
  {name = "dev.shipping.db_host", value = "mysql-dev.saraldevops.site" , type = "String"},
  {name = "dev.payment.cart_host", value = "cart-dev.saraldevops.site" , type = "String"},
  {name = "dev.payment.cart_port", value = "80" , type = "String"},
  {name = "dev.payment.user_host", value = "user-dev.saraldevops.site" , type = "String"},
  {name = "dev.payment.user_port", value = "80" , type = "String"},
  {name = "dev.payment.amqp_host", value = "rabbitmq-dev.saraldevops.site" , type = "String"},
  {name = "dev.catalogue.mongo", value = "true" , type = "String"},
  {name = "dev.catalogue.mongo_url", value = "mongodb://mongodb-dev.saraldevops.site:27017/catalogue" , type = "String"},
  {name = "dev.cart.redis_host", value = "redis-dev.saraldevops.site" , type = "String"},
  {name = "dev.cart.catalogue_host", value = "catalogue-dev.saraldevops.site" , type = "String"},
  {name = "dev.cart.catalogue_port", value = "80" , type = "String"},
  {name = "dev.mysql.mysql_url" , value = "mysql-dev.saraldevops.site" , type = "String"},
  {name = "dev.mongodb.mongodb_url" , value = "mongodb-dev.saraldevops.site" , type = "String"}

]

### THIS IS NOT GOING TO BE THE PRACTICE IN COMPANIES , WE SHOULD NOT KEEP PASSWORDS IN GIT REPOS
secrets = [
  {name = "dev.mysql.password", value = "RoboShop@1" , type = "SecureString"},
  {name = "dev.payment.amqp_user", value = "roboshop" , type = "SecureString"},
  {name = "dev.payment.amqp_pass", value = "roboshop123" , type = "SecureString"},
  {name = "dev.rabbitmq.amqp_user", value = "roboshop" , type = "SecureString"},
  {name = "dev.rabbitmq.amqp_pass", value = "roboshop123" , type = "SecureString"},
#  {name = "dev.rabbitmq.amqp_pass", value = "roboshop123" , type = "SecureString"},
  {name = "dev.docdb.user", value = "admin1" , type = "SecureString"},
  {name = "dev.docdb.pass", value = "RoboShop1" , type = "SecureString"},
  {name = "dev.rds.user", value = "admin1" , type = "SecureString"},
  {name = "dev.rds.pass", value = "RoboShop1" , type = "SecureString"}


]
