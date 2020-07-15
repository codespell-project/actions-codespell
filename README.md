# Codespell with GitHub Actions -- including annotations for Pull Requests

This GitHub Actions runs codespell over your code.
Any warnings or errors will be annotated in the Pull Request.

## Usage

```
uses: codespell-project/actions-codespell@master
```

### Parameter: check_filenames

If set, check file names for speling mistakes as well.

This parameter is optional; by default `codespell` will only check the file contents.

```
uses: codespell-project/actions-codespell@master
with:
  check_filenames: true
```

### Parameter: check_hidden

If set, check hidden files (those starting with ".") for spelling mistakes as well.

This parameter is optional; by default `codespell` will not check hidden files.

```
uses: codespell-project/actions-codespell@master
with:
  check_hidden: true
```

### Parameter: exclude_file

File with lines that should not be checked for spelling mistakes.

This parameter is optional; by default `codespell` will check all lines.

```
uses: codespell-project/actions-codespell@master
with:
  exclude_file: src/foo
```

### Parameter: skip

Comma-separated list of files to skip (it accepts globs as well).

This parameter is optional; by default `codespell` won't skip any files.

```
uses: codespell-project/actions-codespell@master
with:
  skip: foo,bar
```

### Parameter: path

Indicates the path to run `codespell` in.
This can be useful if your project has code you don't want to spell check for some reason.

This parameter is optional; by default `codespell` will run on your whole repository.

```
uses: codespell-project/actions-codespell@master
with:
  path: src
```

### Parameter: only_warn

Only warn about problems.
All errors and warnings are annotated in Pull Requests, but it will act like everything was fine anyway.
(In other words, the exit code is always 0.)

This parameter is optional; setting this to any value will enable it.

```
uses: codespell-project/actions-codespell@master
with:
  only_warn: 1
```
