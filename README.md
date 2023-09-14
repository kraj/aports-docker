# aports-docker
Docker Environment for Developing alpine aports packages

building ppc64 alpine Docker

```
DOCKER_BUILDKIT=1 docker build --tag test/alpine-ppc64le --platform linux/ppc64le .
```
Run
```
docker run --rm -it test/alpine-ppc64le
```

Native image

building
```
docker build -t khems-alpine .
```

Run
```
docker run --rm khems-alpine
```

RISCV64

building

```
git checkout -b riscv64 origin/riscv64
DOCKER_BUILDKIT=1 docker build --tag test/alpine-riscv64 --platform linux/riscv64 .
```

Run

```
docker run --rm -it test/alpine-riscv64
```
