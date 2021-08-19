# Static Web Server

A bare minimum web server that only serves static files over the internet

## Install

```shell
git clone https://github.com/junekimdev/gostaticserver.git staticserver
cd staticserver
```

## Build

### Building Go directly

This will build an executable file in the working directory

```shell
go build -o main
```

### Using Docker (Recommended)

This will build a docker image

```shell
# shortest
make

# Same as above
make build

# Without cache
make bf
```

## Use

### Without building compiling Go

```shell
go run ./main.go
```

### With compiled file from go build

```shell
./main
```

### With Docker image

```shell
make up
```

## Add & Serve

### Add files

1. Create a directory named `public` in the working directory
2. Put files in `./public`

> files in `./public` can be accessed via `https://mydomain.com/myfile.ext`

### Add directories

1. Create directories in `./public`
2. Add files in the created directory

> files in `./public/mydir` can be accessed via `https://mydomain.com/mydir/myfile.ext`

:warning: Accessing the directory requires `index.html` in the said directory

> `index.html` in `./public/mydir` will be accessed via `https://mydomain.com/mydir`

## 404

If client tries to access a file that is not in the server, the server will return `404`
