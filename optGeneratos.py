from os import environ
import random
import smtplib

def SendOTP(email:str):
    otp="".join([str(random.randint(0,9)) for i in range(4)])

    server=smtplib.SMTP('smtp.gmail.com',587)
    server.starttls()
    server.login(environ.get('emailserver'),environ.get('passwordemail'))
    smg='Hola!, tu codigo es -> {0}'.format(str(otp))
    server.sendmail(environ.get('emailserver'),email,smg)
    server.quit()
    return otp