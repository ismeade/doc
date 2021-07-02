
## 概述 ##
RESTful是一种风格，不是一种规范。

## HTTP协议 ##

通常使用HTTPs协议

## 域名 ##

```url
https://api.51vcheck.cn
```

## 版本 ##
**标准做法是放在HTTP头里**

如：[github](https://docs.github.com/cn/rest/overview/resources-in-the-rest-api)

**方便的方法是放到URL里**
```
https://api.51vcheck.cn/v1/
```

## 资源 ##
RESTful中，每一个资源都有一个网址代表，如：
```
https://api.51vcheck.cn/cloud/user

```

**每一个网址代表一种资源，避免出现动词**

## 资源操作 ##
常用的HTTP动词:
- GET 获取资源
- POST 新建资源
- PUT 编辑资源
- DELETE 删除资源
  
例子：
```
获取所有用户
GET https://api.51vcheck.cn/cloud/user
获取用户信息
GET https://api.51vcheck.cn/cloud/user/{userId}
获取用户所有角色
GET https://api.51vcheck.cn/cloud/user/{userId}/role
获取用户所有地址
GET https://api.51vcheck.cn/cloud/user/{userId}/address

新建用户
POST https://api.51vcheck.cn/cloud/user
新建用户地址
POST https://api.51vcheck.cn/cloud/user/{userId}/address

新建token
POST https://api.51vcheck.cn/auth/token

更新用户
PUT https://api.51vcheck.cn/cloud/user/{userId}
更新用户地址
PUT https://api.51vcheck.cn/cloud/user/{userId}/address/{addressId}

删除用户
DELETE https://api.51vcheck.cn/cloud/user/{userId}
删除用户地址
DELETE https://api.51vcheck.cn/cloud/user/{userId}/address/{addressId}
```

_授权服务中的“获取token”用什么操作_


## 过滤条件 ##

```
GET https://api.51vcheck.cn/cloud/user?page=1&pageSize=10

GET https://api.51vcheck.cn/cloud/user?page=1&pageSize=10&status=1
GET https://api.51vcheck.cn/cloud/user?page=1&pageSize=10&sortby=create_time&order=desc


GET https://api.51vcheck.cn/cloud/user/{userId}/address
等于
GET https://api.51vcheck.cn/cloud/address?userId={userId}

```

## 状态码 ##
- 200 OK - [GET]：服务器成功返回用户请求的数据，该操作是幂等的（Idempotent）。
- 201 CREATED - [POST/PUT]：用户新建或修改数据成功。
- 202 Accepted - [*]：表示一个请求已经进入后台排队（异步任务）
- 204 NO CONTENT - [DELETE]：用户删除数据成功。
- 400 INVALID REQUEST - [POST/PUT]：用户发出的请求有错误，服务器没有进行新建或修改数据的操作，该操作是幂等的。
- 401 Unauthorized - [*]：表示用户没有权限（令牌、用户名、密码错误）。
- 403 Forbidden - [*] 表示用户得到授权（与401错误相对），但是访问是被禁止的。
- 404 NOT FOUND - [*]：用户发出的请求针对的是不存在的记录，服务器没有进行操作，该操作是幂等的。
- 406 Not Acceptable - [GET]：用户请求的格式不可得（比如用户请求JSON格式，但是只有XML格式）。
- 410 Gone -[GET]：用户请求的资源被永久删除，且不会再得到的。
- 422 Unprocesable entity - [POST/PUT] 当创建一个对象时，发生一个验证错误。
- 500 INTERNAL SERVER ERROR - [*]：服务器发生错误，用户将无法判断发出的请求是否成功。

## 错误码 ##

如果状态码事4xx，应该向用户返回出错信息
```json
{
    "error": "Invalid API key"
}    
```

## 返回结果 ##
- GET /user：返回资源对象的列表（数组）
- GET /user/{userId}：返回单个资源对象
- POST /user：返回新生成的资源对象
- PUT /user/{userId}：返回完整的资源对象
- DELETE /user/{userId}：返回一个空文档


## 资料 ##
- [RESTfu架构](https://www.ruanyifeng.com/blog/2011/09/restful.html)
- [RESTful设计指南](https://www.ruanyifeng.com/blog/2014/05/restful_api.html)
- [GitHub REST Api](https://docs.github.com/cn/rest)