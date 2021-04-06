# GKE Quickstart

## Technologoy used
- on local
```
$ gcloud version 
Google Cloud SDK 318.0.0
alpha 2020.11.06
beta 2020.11.06
bq 2.0.62
core 2020.11.06
gsutil 4.54
kubectl 1.16.13
```

```
$ kubectl version
Client Version: version.Info{Major:"1", Minor:"16", GitVersion:"v1.16.2", GitCommit:"c97fe5036ef3df2967d086711e6c0c405941e14b", GitTreeState:"clean", BuildDate:"2019-10-15T19:18:23Z", GoVersion:"go1.12.10", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"18+", GitVersion:"v1.18.12-gke.1210", GitCommit:"199a41188dc0ca5d6d95b1cc7e8ba96e05f9dd0a", GitTreeState:"clean", BuildDate:"2021-02-05T18:03:16Z", GoVersion:"go1.13.15b4", Compiler:"gc", Platform:"linux/amd64"}
```

```
$ helm version
version.BuildInfo{Version:"v3.4.1", GitCommit:"c4e74854886b2efe3321e185578e6db9be0a6e29", GitTreeState:"clean", GoVersion:"go1.14.11"}
```

```
$ argocd version
argocd: v1.8.5+d0f8edf
  BuildDate: 2021-02-20T05:38:50Z
  GitCommit: d0f8edfec804c013d4fc535e8b9022eb47602617
  GitTreeState: clean
  GoVersion: go1.14.12
  Compiler: gc
  Platform: linux/amd64
argocd-server: v1.8.4+28aea3d
  BuildDate: 2021-02-05T17:56:06Z
  GitCommit: 28aea3dfdede00443b52cc584814d80e8f896200
  GitTreeState: clean
  GoVersion: go1.14.12
  Compiler: gc
  Platform: linux/amd64
  Ksonnet Version: v0.13.1
  Kustomize Version: v3.8.1 2020-07-16T00:58:46Z
  Helm Version: v3.4.1+gc4e7485
  Kubectl Version: v1.17.8
```
---

- on Gitlab Runner with `docker:19.03.13-dind`
```
$ docker version
Client: Docker Engine - Community
 Version:           19.03.11

略

Server: Docker Engine - Community
 Engine:
  Version:          19.03.13
略
```

## Ref.
- [[Gitlab RunnerとArgo CD使用]GitOpsスタイルなCI/CDパイプラインを構築したのでふりかえる](https://zenn.dev/gkz/articles/cicd-argocd-runner)

## License
Copyright (c) 2021 [gkz](https://gkz.mit-license.org/2021)

Licensed under the [MIT license](LICENSE).

Unless attributed otherwise, everything is under the MIT licence. Some stuff is not from me, and without attribution, and I no longer remember where I got it from. I apologize for that.
