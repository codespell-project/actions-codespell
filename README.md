# Flake8 with GitHub Actions -- including annotations for Pull Requests

This GitHub Actions runs flake8 over your code.
Any warnings or errors will be annoted in the Pull Request.

## Usage

```
uses: TrueBrain/actions-flake8@master
```

### Parameter: path

Indicates the path to run `flake8` in.
This can be useful if your project is more than Python code.

This parameter is optional; by default `flake8` will run on your whole repository.

```
uses: TrueBrain/actions-flake8@master
with:
  path: src
```

### Parameter: only_warn

Only warn about problems.
All errors and warnings are annotated in Pull Requests, but it will act like everything was fine anyway.
(In other words, the exit code is always 0.)

This parameter is optional; setting this to any value will enable it.

```
uses: TrueBrain/actions-flake8@master
with:
  only_warn: 1
```
