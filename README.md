### Hexlet tests and linter status:
[![Actions Status](https://github.com/qsimpleq/bulletin-board/workflows/hexlet-check/badge.svg)](https://github.com/qsimpleq/bulletin-board/actions)
[![CI](https://github.com/qsimpleq/bulletin-board/actions/workflows/ci.yml/badge.svg)](https://github.com/qsimpleq/bulletin-board/actions/workflows/ci.yml)

# Bulletin board
Simple way to publish your bulletins and share with others.

Link to service demo: [example-bulletin-board](https://example-bulletin-board.qsimpleq.su)

Deployed with self-hosted [dokku](https://dokku.com)

## Local development
```shell
make setup
bin/rails db:seed
```
Put your github credentials to .env file and run

```shell
make dev
```

### Extra commands
```shell
make lint
make test
make test-lint
make lint-test
```

Run erb2slim with rubocop autofixer: 
```shell
make fixer
```
