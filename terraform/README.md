После инициализации

`$ terraform init`

необхоимо задать переменые окружения
 - `$ export YC_TOKEN=$(yc iam create-token)` -- используется для авторизации;

- `$ export YC_FOLDER_ID=$(yc config get folder-id)` -- значение которой вроде как должно само подхватываться, но приходится подпихивать костылём (см. ниже).

Создаем инфру:

`$ terraform apply -var folder_id=$YC_FOLDER_ID -var image_tag=1`
