# Globalping Toolkit Docker Image

[![Docker Pulls](https://img.shields.io/docker/pulls/adamiy/globalping-toolkit.svg)](https://hub.docker.com/r/adamiy/globalping-toolkit)
[![GitHub Stars](https://img.shields.io/github/stars/adamori/globalping-toolkit.svg)](https://github.com/adamori/globalping-toolkit)

A lightweight Docker image containing `globalping-cli`, `curl`, and other essential utilities.

Follow the [Globalping CLI documentation](https://github.com/jsdelivr/globalping-cli) for more details on how to use `globalping-cli`.

## ✨ Features

* **`globalping-cli`**: Comes with `globalping-cli` v1.5.0 pre-installed.
* **Lightweight**: Built on the minimal `alpine:3.22` base image.
* **Multi-Arch**: Ready to be built for different architectures like `amd64` and `arm64`.

## 🚀 How to Use

### Pull from Docker Hub

The pre-built image is available on Docker Hub.

```sh
docker pull adamiy/globalping-toolkit:latest
```

### Usage with `docker run`

**1. Run an interactive shell:**

This is useful for debugging or exploring the container's environment.

```sh
docker run -it --rm adamiy/globalping-toolkit:latest
```

**2. Run a one-off command:**

You can easily run any `globalping` command directly.

```sh
docker run --rm adamiy/globalping-toolkit:latest globalping http example.com from Germany
```

### Usage with Kubernetes (CronJob Example)

This image is suitable for running scheduled jobs in Kubernetes. The example below defines a basic health check that runs every 15 minutes. The job's success or failure depends on the exit code of the `globalping` command.

```yaml
# cronjob-example.yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: website-health-check
spec:
  schedule: "*/15 * * * *" # Runs every 15 minutes
  jobTemplate:
    spec:
      template:
        spec:
          containers:
            - name: globalping-check
              image: adamiy/globalping-toolkit:latest
              imagePullPolicy: IfNotPresent
              # The command to run. Customize it for your needs.
              command:
                - /bin/sh
                - -c
                - |
                  # This is a basic check. The job will succeed if globalping exits with 0,
                  # and fail otherwise.
                  #
                  echo "Pinging your-service.example.com from 3 probes in Europe..."
                  globalping http --limit 3 your-service.example.com from Europe
          # 'OnFailure' will restart the job if the command fails, which might be useful for transient errors.
          # Use 'Never' if you don't want retries within the same job run.
          restartPolicy: OnFailure
```

## 🛠️ Building the Image Locally

To build the image yourself, clone the repository and run the Docker build command.

```sh
git clone [https://github.com/adamori/globalping-toolkit.git](https://github.com/adamori/globalping-toolkit.git)
cd globalping-toolkit
docker build -t adamiy/globalping-toolkit:latest .
```

### Customization

You can customize the version of `globalping-cli` at build time using the `GLOBALPING_VERSION` build argument.

```sh
docker build --build-arg GLOBALPING_VERSION=1.4.0 -t adamiy/globalping-toolkit:custom .
```

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/adamori/globalping-toolkit/issues).

## 📄 License

This project is licensed under the MIT License.
