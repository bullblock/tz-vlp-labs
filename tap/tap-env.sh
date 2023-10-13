export IMGPKG_REGISTRY_HOSTNAME_0=registry.tanzu.vmware.com
export IMGPKG_REGISTRY_USERNAME_0="xinstevenl@vmware.com"
export IMGPKG_REGISTRY_PASSWORD_0='Admin!23Admin'
export IMGPKG_REGISTRY_HOSTNAME_1=harbor.vlp.tanzulab.biz
export IMGPKG_REGISTRY_USERNAME_1="devops"
export IMGPKG_REGISTRY_PASSWORD_1='Admin!23Admin'
export INSTALL_REGISTRY_HOSTNAME=harbor.vlp.tanzulab.biz
export INSTALL_REGISTRY_USERNAME="devops"
export INSTALL_REGISTRY_PASSWORD='Admin!23Admin'
export TAP_VERSION="1.5.1"
export TBS_VERSION="1.10.9"
export INSTALL_REPO=xinstevenl
imgpkg tag list -i registry.tanzu.vmware.com/tanzu-application-platform/tap-packages | sort -V
imgpkg copy -b registry.tanzu.vmware.com/tanzu-application-platform/tap-packages:${TAP_VERSION} --to-repo ${INSTALL_REGISTRY_HOSTNAME}/${INSTALL_REPO}/tap-packages
kubectl create ns tap-install
tanzu secret registry add tap-registry --username ${INSTALL_REGISTRY_USERNAME} --password ${INSTALL_REGISTRY_PASSWORD} --server ${INSTALL_REGISTRY_HOSTNAME} --export-to-all-namespaces --yes --namespace tap-install
tanzu secret registry add registry-credentials --server   ${INSTALL_REGISTRY_HOSTNAME} --username ${INSTALL_REGISTRY_USERNAME} --password ${INSTALL_REGISTRY_PASSWORD} --namespace tap-install --export-to-all-namespaces --yes
tanzu package repository add tanzu-tap-repository --url ${INSTALL_REGISTRY_HOSTNAME}/${INSTALL_REPO}/tap-packages:${TAP_VERSION} --namespace tap-install
tanzu package repository get tanzu-tap-repository --namespace tap-install
tanzu package available list --namespace tap-install
tanzu package available list tap.tanzu.vmware.com --namespace tap-install
tanzu package install tap -p tap.tanzu.vmware.com -v ${TAP_VERSION} --values-file tap-value-maz9.yaml -n tap-install
tanzu package available list buildservice.tanzu.vmware.com --namespace tap-install
imgpkg copy -b registry.tanzu.vmware.com/tanzu-application-platform/full-tbs-deps-package-repo:${TBS_VERSION} --to-repo ${INSTALL_REGISTRY_HOSTNAME}/${INSTALL_REPO}/tbs-full-deps
tanzu package repository add tbs-full-deps-repository --url ${INSTALL_REGISTRY_HOSTNAME}/${INSTALL_REPO}/tbs-full-deps:${TBS_VERSION} --namespace tap-install
tanzu package install full-tbs-deps -p full-tbs-deps.tanzu.vmware.com -v ${TBS_VERSION} -n tap-install
tanzu secret registry add registry-credentials --server ${INSTALL_REGISTRY_HOSTNAME} --username ${INSTALL_REGISTRY_USERNAME} --password ${INSTALL_REGISTRY_PASSWORD} --namespace default
kubectl apply -f tap-default.yaml -n default

