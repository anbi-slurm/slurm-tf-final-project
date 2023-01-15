Для сборки образа packer'ом необходимо передать через переменную image_tag числовой тег (см. пример ниже)

$ packer build -var 'image_tag=3' nginx.pkr.hcl
