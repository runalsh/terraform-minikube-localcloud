resource "kubectl_manifest" "manifests" {
    count     = length(data.kubectl_filename_list.manifests.matches)
    yaml_body = file(element(data.kubectl_filename_list.manifests.matches, count.index))
}

data "kubectl_filename_list" "manifests" {
    pattern = "./manifests/*.yaml"
}