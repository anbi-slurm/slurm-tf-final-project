Авторизуемся в облаке через токен в переменной окружения

`$ export YC_TOKEN=$(yc iam create-token)`

и указываем filder_id

`$ export YC_FOLDER_ID=$(yc config get folder-id)`

Для сборки образа packer'ом необходимо передать через переменную _image_tag_ числовой тег (см. пример ниже)

$ packer build -var 'image_tag=3' nginx.pkr.hcl
