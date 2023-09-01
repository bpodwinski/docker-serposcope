# Supported tags and respective `Dockerfile` links

`latest` [*(bpodwinski/docker-dolibarr)*](https://github.com/bpodwinski/docker-serposcope)<br>

### What is this ?

Serposcope is a free rank tracker to monitor websites rankings in search engines and improve SEO. More details on the [official website](https://www.serposcope.com/).

### Features

- Based on Ubuntu
- Latest stable versions

### Ports

- **6333**

### Environment

| Variable | Type | Default value |
| -------- | ---- | ------------- |
| **N/A** | *n/a* | N/A


### Volumes

You can attach a volume to your container:

- Database folder: `/usr/share/serposcope/db`

Use the flag -v to mount a volume on the host machine like described in [official Docker documentation](https://docs.docker.com/engine/userguide/containers/dockervolumes/).
