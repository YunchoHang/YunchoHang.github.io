---
title: "KubanCTF 2025 - Secret Archive"
date: 2025-08-26
draft: false
tags: ["Web", "blog", "CTF", "IDOR"]
categories: ["CTF Writeups"]
featureimage: "feature-image.png" 
showHero: true
heroStyle: "background"
description: "Web challenge writeup from KubanCTF 2025 involving an IDOR vulnerability."
---   
# Secret Archive

> Where other people's secrets are stored, security is nothing but an illusion. Find a way to reach the forbidden.
> 

### Application Analysis

The challenge provides the source code for a Flask web application that functions as a password vault. Users can register, log in, and manage their passwords (add, view, update).

![](/posts/SecretArchive/images/image.png)

The application uses SQLite to store users and their passwords, with routes like /getPass/int:user_id to fetch passwords for a given user ID.

### Vulnerability Identification

Upon reviewing app.py, the `/getPass/int:user_id` endpoint stood out:

```python
from flask import Flask, render_template, redirect, url_for, session, request, jsonify
from werkzeug.security import generate_password_hash, check_password_hash
import sqlite3
import os
import secrets
from utils import init_db, get_user_by_username, create_user, get_passwords_by_user_id, add_password, update_password

app = Flask(__name__)
app.secret_key = secrets.token_hex(32)
DATABASE = 'database.db'

if not os.path.exists(DATABASE):
    init_db(DATABASE)

@app.route('/')
def home():
    if 'user_id' not in session:
        return redirect(url_for('login'))
    return render_template('index.html', user_id=session['user_id'])

@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user = get_user_by_username(DATABASE, username)
        if user and check_password_hash(user[2], password):
            session['user_id'] = user[0]
            return redirect(url_for('home'))
        else:
            error = "Invalid username or password"
    return render_template('login.html', error=error)

@app.route('/register', methods=['GET', 'POST'])
def register():
    error = None
    if request.method == 'POST':
        username = request.form['username']
        password = generate_password_hash(request.form['password'])
        existing = get_user_by_username(DATABASE, username)
        if existing:
            error = "User already exists"
        else:
            create_user(DATABASE, username, password)
            return redirect(url_for('login'))
    return render_template('register.html', error=error)

@app.route('/getPass/<int:user_id>')
def get_pass(user_id):
    if 'user_id' not in session:
        return redirect(url_for('login'))
    passwords = get_passwords_by_user_id(DATABASE, user_id)
    return jsonify(passwords)

@app.route('/addPass', methods=['POST'])
def add_pass():
    if 'user_id' not in session:
        return redirect(url_for('login'))
    description = request.form['description']
    value = request.form['value']
    add_password(DATABASE, session['user_id'], description, value)
    return redirect(url_for('home'))

@app.route('/updatePass', methods=['POST'])
def update_pass():
    if 'user_id' not in session:
        return redirect(url_for('login'))
    pid = request.form['pid']
    description = request.form['description']
    value = request.form['value']
    update_password(DATABASE, session['user_id'], pid, description, value)
    return redirect(url_for('home'))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)

```

The issue was that the endpoint checks if the user is logged in ('user_id' in session) but **does not verify** if the requested user_id matches the logged-in user's session['user_id'].  Classic IDOR Vulnerability that allows any authenticated user to retrieve passwords for any user_id, including other users and admin.

### **Exploitation**

Registering a user:

Sending a POST request to the server

![](/posts/SecretArchive/images/image1.png)

Logging in:

Sending a POST request to authenticate and save the session cookie

![](/posts/SecretArchive/images/image2.png)

Exploiting IDOR:

![](/posts/SecretArchive/images/image3.png)

So by using the session cookie to request the password for the user_id=1 the response we get is a JSON array of the password entries and the value contained the flag. 

If user_id=1 didn’t yield the flag, I would have enumerated other IDs (e.g., /getPass/2, /getPass/3), but the flag was found in user_id=1.

### Conclusion

The "Secret Archive" challenge was solved by exploiting an IDOR vulnerability in the /getPass/int:user_id endpoint. By registering a user, logging in, and requesting passwords for user_id=1, the flag was retrieved from the JSON response. This challenge highlights the importance of proper authorization checks in web applications.

flag: `CSC{BR34CH_TH3_V4ULT_4ND_T4K3_1T}`