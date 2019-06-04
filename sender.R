# sender

options(encoding = "latin1")
#Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jdk1.8.0_201')
library(readr)
library(rJava)
library(mailR)
library(png)


# png(file.path(getwd(), image, "test.png")); plot(0); dev.off()
# Gmail users may have to switch https://www.google.com/settings/security/lesssecureapps before the send
send.mail(from = "duroy.raphael@gmail.com",
          to = "thomas.reignard@iacpartners.com",
          subject = "Newsletter IAC",
          #body = '<img src="logo-iac-white.png">',
          body = 'template.html',
          html = TRUE,
          inline = TRUE,
          smtp = list(host.name = "smtp.gmail.com", 
                      port = 465, 
                      user.name = "duroy.raphael@gmail.com", 
                      passwd = "raphaelduroygmail", 
                      ssl = TRUE),
          authenticate = TRUE,
          send = TRUE)

  