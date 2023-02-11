tinkerbell2=192.168.0.46
loadbalancer_ip=$tinkerbell2
helm_chart_version=0.2.0
loadbalancer_interface="enp0s3" 
namespace="tink-system"
helm inspect values oci://ghcr.io/tinkerbell/charts/stack --version "$helm_chart_version" >/tmp/stack-values.yaml
sed -i "s/192.168.2.111/${loadbalancer_ip}/g" /tmp/stack-values.yaml
trusted_proxies=$(kubectl get nodes -o jsonpath='{.items[*].spec.podCIDR}' | tr ' ' ',') 
helm install stack-release oci://ghcr.io/tinkerbell/charts/stack --version $helm_chart_version \
    --create-namespace --namespace $namespace --wait \
    --set boots.trustedProxies=$trusted_proxies \
    --set hegel.trustedProxies=$trusted_proxies \
    --set kubevip.interface=$loadbalancer_interface \
    --values /tmp/stack-values.yaml
