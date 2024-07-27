# Helm Chart for My Application

This Helm chart deploys "My Application" on a Kubernetes cluster using the Helm package manager. The chart includes support for exposing HTTP and TCP services through an Istio Gateway, with options for custom domain names, CORS policies, and additional response headers. This documentation follows the Bitnami style, providing a straightforward and concise guide to configuring and deploying the chart.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.1.0
- PV provisioner support in the underlying infrastructure (if persistence is required)
- Istio 1.5+ (if you plan to use Istio gateway features)

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
helm install my-release path/to/chart
```

The command deploys "My Application" on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
helm delete my-release
```

This command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

### Postgresql Parameters

### Self Signed Certificate Parameters

### Namespace Image Pull Secret Parameters

### Automated CICD Parameters
The following table lists the configurable parameters related to the CI/CD features of the chart and their default values.

| Parameter                             | Description                                                            | Default |
| ------------------------------------- | ---------------------------------------------------------------------- | ------- |
| `cicd.enabled`                        | Enable CI/CD resources for automation processes                        | `false` |


### Rook Ceph Object Storage
The following table lists the configurable parameters of the Rook Ceph ObjectBucket chart and their default values.

| Parameter                        | Description                                      | Default                |
| -------------------------------- | ------------------------------------------------ | ---------------------- |
| `global.organization`            | Organization label for bucket                    | `nil`                  |
| `application.name`               | Application name label for bucket                | `nil`                  |
| `application.environment`        | Application environment label for bucket         | `nil`                  |
| `objectStorage[].name`           | Name of the storage bucket                       | `nil`                  |
| `objectStorage[].additionalConfig`| Additional configuration for the storage bucket | `{}`                   |



### Gateway Paramters

The following table lists the configurable parameters of the "My Application" chart and their default values.

| Parameter                                         | Description                                      | Default                                                 |
|---------------------------------------------------|--------------------------------------------------|---------------------------------------------------------|
| `gateway.enabled`                                 | Enable gateway                                   | `true`                                                  |
| `gateway.exposeServices.enabled`                  | Enable exposing services through the gateway     | `true`                                                  |
| `gateway.exposeServices.domains`                  | List of domains to be exposed                    | `[{"name": "https://example.com"}]`                     |
| `gateway.namespace`                               | Gateway namespace (for Istio)                    | `istio-gateway`                                         |
| `gateway.name`                                    | Gateway name                                     | `gateway-name`                                          |
| `gateway.hstsMaxAge`                              | HSTS max age header for HTTPS                    | `86400`                                                 |
| `gateway.corsPolicy`                              | CORS policy configuration                        | See values.yaml                                         |
| `application.name`                                | Application name                                 | `my-application`                                        |
| `application.environment`                         | Application environment                          | `production`                                            |
| `global.organization`                             | Global organization name                         | `my-organization`                                       |

---
### Customizing the Chart Before Installing

To edit the default configuration, use:

```bash
helm show values path/to/chart > values.yaml
```

Edit the `values.yaml` file, then install the chart with the changes:

```bash
helm install my-release path/to/chart -f values.yaml
```

## Configuration and Installation Details

### Exposing Services

This chart allows exposing HTTP and TCP services through an Istio Gateway. You can customize the exposed services by modifying the `gateway.exposeServices.domains` parameter. Each domain can expose multiple `httpServices` and `tcpServices`, with options for setting match prefixes, ports, and additional response headers.

### CORS Policy

You can configure a CORS policy for your services by setting the `gateway.corsPolicy` parameter. This allows you to specify allowed origins, headers, and whether credentials are supported.

## Persistence

"The Application" does not store data persistently. If your application requires persistence, you need to integrate an external database or storage solution.

## Troubleshooting

- **Issue**: I cannot access my service through the specified domain.
  
  **Solution**: Ensure that the domain name is correctly configured in your DNS provider and that the Istio Gateway is properly set up to handle traffic for that domain.

For more detailed troubleshooting, refer to the Helm and Istio documentation.

## Upgrading

To upgrade the chart deployment:

```bash
helm upgrade my-release path/to/chart -f values.yaml
```

Ensure you review the [Parameters](#parameters) section and adjust your `values.yaml` file accordingly to prevent unwanted changes or issues during the upgrade.

---

This documentation provides a basic overview of deploying and managing "My Application" using Helm. For more advanced configurations and features, refer to the Helm and Istio documentation.