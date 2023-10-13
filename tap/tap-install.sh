export IMGPKG_REGISTRY_HOSTNAME_0="registry.tanzu.vmware.com"
export IMGPKG_REGISTRY_USERNAME_0="xinstevenl@vmware.com"
export IMGPKG_REGISTRY_PASSWORD_0='Admin!23Admin'
export IMGPKG_REGISTRY_HOSTNAME_1="harbor.vlp.tanzulab.biz:8443"
export IMGPKG_REGISTRY_USERNAME_1="devops"
export IMGPKG_REGISTRY_PASSWORD_1='Admin!23Admin'
export INSTALL_REGISTRY_HOSTNAME="harbor.vlp.tanzulab.biz:8443"
export INSTALL_REGISTRY_USERNAME="devops"
export INSTALL_REGISTRY_PASSWORD='Admin!23Admin'
export TAP_VERSION="1.5.6"
export TBS_VERSION="1.10.13"
export INSTALL_REPO=tanzulab
tanzu package install tap -p tap.tanzu.vmware.com -v ${TAP_VERSION} --values-file tap-value-gcr.yaml -n tap-install
sleep 100
tanzu package install full-tbs-deps -p full-tbs-deps.tanzu.vmware.com -v ${TBS_VERSION} -n tap-install
sleep 30
tanzu secret registry add registry-credentials --server ${INSTALL_REGISTRY_HOSTNAME} --username ${INSTALL_REGISTRY_USERNAME} --password ${INSTALL_REGISTRY_PASSWORD} --namespace default
kubectl apply -f tap-default.yaml -n default

