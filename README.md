![MongoCamp Logo](https://server.mongocamp.dev/logo_with_text_right.png)

## Introduction
This GitHub Action starts a MongoDB server with the default port `27017`. You can customize the port using the `mongodb-port` input.

The version of the MongoDb server must be specified using the `mongodb-version` input. The used version must exist in the published [`mongocamp/mongodb` Docker hub tags](https://hub.docker.com/r/mongocamp/mongodb/tags). Default value is `latest`, other possible choices are `7.0`, or `8.0.11`.

## Usage
```yaml
name: Run tests

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        mongodb-version: ['4.4.14', '5.0.9']

    steps:
    - name: Git checkout
      uses: actions/checkout@v2

    - name: Start MongoDB
      uses: MongoCamp/mongodb-github-action@1.0.0
      with:
        mongodb-version: ${{ matrix.mongodb-version }}

    - run: curl http://localhost:27017
```


### Using a Custom MongoDB Port
The following sample starts a MongoDB server on port `4711`:

```yaml
name: Run tests

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        mongodb-version: ['4.4.14', '5.0.9']

    steps:
      - name: Git checkout
        uses: actions/checkout@v2

      - name: Start MongoDB
        uses: MongoCamp/mongodb-github-action@1.0.0
        with:
          mongodb-version: ${{ matrix.mongodb-version }}
          mongodb-port: 4711

      - run: curl http://localhost:4711
```


### With a Replica Set
The following sample uses the replica set name `your-replica-set`:

```yaml
name: Run tests

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        mongodb-version: ['4.4.14', '5.0.9']

    steps:
      - name: Git checkout
        uses: actions/checkout@v2

      - name: Start MongoDB
        uses: MongoCamp/mongodb-github-action@1.0.0
        with:
          mongodb-version: ${{ matrix.mongodb-version }}
          mongodb-replica-set: your-replica-set

      - run: curl http://localhost:27017
```


### With Authentication
The following sample uses the username `user` and the password `your-pwd`:


```yaml
name: Run tests

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        mongodb-version: ['4.4.14', '5.0.9']

    steps:
      - name: Git checkout
        uses: actions/checkout@v2

      - name: Start MongoDB
        uses: MongoCamp/mongodb-github-action@1.0.0
        with:
          mongodb-version: ${{ matrix.mongodb-version }}
          mongodb-username: user
          mongodb-pwd: your-pwd

      - run: curl http://localhost:27017
```
