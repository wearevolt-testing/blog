# Blog 

## Url:
```
https://blog-task-test.herokuapp.com/
```
## Аналитический отчет:
```
База данных была заполнена за период: с 2014 по 2017 год
```
## Эндпоинт для аутентификации:
**Поля:**
- email
- password
```
POST https://blog-task-test.herokuapp.com/api/v1/auth_tokens
```
```
Тестовый пользователь:
email: author@example.com
password: 111111
auth_token: qHqW_qJ6yQApJRH_fM8Q
```
## Эндпоинты для записей в блоге:
**Заголовок**
- X-Auth-Token

**Создать запись:**
- title
- body
- published_at
```
POST https://blog-task-test.herokuapp.com/api/v1/posts
```
**Получить запись:**
- post_id
```
GET https://blog-task-test.herokuapp.com/api/v1/posts/:post_id
```
**Получить коллекцию записей:**
- page
- per_page
```
GET https://blog-task-test.herokuapp.com/api/v1/posts
```
## Эндпоинты для комментариев:
**Заголовок**
- X-Auth-Token

**Создать комментарий:**
- comment
    - body
    - published_at
- post_id
```
POST https://blog-task-test.herokuapp.com/api/v1/comments
```
**Удалить комментарий:**
- comment_id
```
DELETE https://blog-task-test.herokuapp.com/api/v1/comments
```
## Эндпоинт для аналитического отчета:
**Создать отчет:**
- start_date
- end_date
- email
```
POST https://blog-task-test.herokuapp.com/api/v1/reports/by_author
