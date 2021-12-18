from flask import Blueprint, render_template, session, redirect

front = Blueprint("frontend", __name__)

@front.route('/')
@front.route('/login')
def login():
    if("token" in session):
        return redirect('/manager')
    return render_template("login.html", title = "login")

@front.route('/manager')
def manager():
    if("token" in session):
        return render_template('manager.html', title = "manager")
    return redirect('/login')

@front.route('/product')
def product():
    if("token" in session):
        return render_template('product.html', title = "Product")
    return redirect('/login')