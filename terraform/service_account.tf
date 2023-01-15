resource "yandex_iam_service_account" "this" {
  name        = "ig-sa"
  description = "service account to mange IG"
}

resource "yandex_resourcemanager_folder_iam_binding" "this" {
  folder_id = var.folder_id
  role      = "editor"

  members = [
    "serviceAccount:${yandex_iam_service_account.this.id}",
  ]
   depends_on = [
     yandex_iam_service_account.this,
   ]
}
