# https://doc.level-labs.com/doc/index.html#login 

# note: demo-account-type has some interesting values
# Values: "default", "overspent", "no-savings-account", "autosave-enabled"

# Assume if I use my credentials I'll get my demo UID and the same token back... maybe not?
curl -H 'Accept: application/json' \
        -H 'Content-Type: application/json' \
        -X POST -d '{"email": "interview@levelmoney.comEROR", "password": "password2", "args": {"uid": 1110590645, "token": "DA2214B6BE2802EF03FEB1533EAB6D7C", "api-token": "AppTokenForInterview", "json-strict-mode": false, "json-verbose-response": false}, "demo-account-type": "default"}' https://2016.api.levelmoney.com/api/v2/core/login
