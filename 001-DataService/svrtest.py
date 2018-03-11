#!/usr/bin/env python

import web
import json

class list_users:
    def GET(self):
        try:
            print('Calling list_users')
            result = json.dumps(users)
            return result
        except:
            raise web.badrequest()

class get_user:
    def GET(self,user):
        try:
            result = json.dumps(users[int(user)])
            return result
        except:
            raise web.notfound()

class userData():
    def __init__(self, id, firstName, lastName):
        self.id = id
        self.firstName = firstName
        self.lastName = lastName

urls = (
    '/users','list_users',
    '/users/(.*)','get_user'
)

users = [userData(1,'Joe','IT').__dict__,userData(2,'Sue','User').__dict__,userData(3,'Toni','Executive').__dict__]

app = web.application(urls,globals())

if __name__ == "__main__":
    print('Starting V1')
    app.run()
