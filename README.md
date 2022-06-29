## Introduction
This GitHub Action starts a MongoDB server with the default port `27017`. You can customize the port using the `mongodb-port` input.

The version of the MongoDb server must be specified using the `mongodb-version` input. The used version must exist in the published [`mongocamp/mongodb` Docker hub tags](https://hub.docker.com/r/mongocamp/mongodb/tags). Default value is `latest`, other possible choices are `4.4.14`, or `5.0.9`.

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
      uses: MongoCamp/mongodb-github-action@0.5.0
      with:
        mongodb-version: ${{ matrix.mongodb-version }}

    - run: curl http://localhost:27017
```


### Using a Custom MongoDB Port
The following example starts a MongoDB server on port `4711`:

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
        uses: MongoCamp/mongodb-github-action@0.5.0
        with:
          mongodb-version: ${{ matrix.mongodb-version }}
          mongodb-port: 4711

      - run: curl http://localhost:4711
```


### With a Replica Set (MongoDB `--replSet` Flag)
You can run your tests against a MongoDB replica set by adding the `mongodb-replica-set: your-replicate-set-name` input in your action’s workflow. The value for `mongodb-replica-set` defines the name of your replica set. Replace `your-replicate-set-name` with the replica set name you want to use in your tests.

The following example uses the replica set name `test-rs`:

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
        uses: MongoCamp/mongodb-github-action@0.5.0
        with:
          mongodb-version: ${{ matrix.mongodb-version }}
          mongodb-replica-set: your-replica-set

      - run: curl http://localhost:27017
```


### With Authentication (MongoDB `--auth` Flag)
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
        uses: MongoCamp/mongodb-github-action@0.5.0
        with:
          mongodb-version: ${{ matrix.mongodb-version }}

      - run: curl http://localhost:27017
```