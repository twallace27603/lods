#!/usr/bin/env python3

import web
import json

class list_users:
    def GET(self):
        print('Calling list_users')
        return json.dumps(users)

class get_user:
    def GET(self,user):
        return json.dumps(users[user])

class userData():
    def __init__(self, firstName, lastName):
        self.firstName = firstName
        self.lastName = lastName

urls = (
    '/users','list_users',
    '/users/(.*)','get_user'
)

users = {'1':userData('Joe','IT').__dict__,'2':userData('Sue','User').__dict__,'3':userData('Toni','Executive').__dict__}

app = web.application(urls,globals())

if __name__ == "__main__":
    print('Starting V1')
    app.run()
