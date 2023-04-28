# Codespell with GitHub Actions -- including annotations for Pull Requests

This GitHub Actions runs codespell over your code.
Any warnings or errors will be annotated in the Pull Request.

## Usage

```yml
uses: codespell-project/actions-codespell@v1
```

### Parameter: check_filenames

If set, check file names for spelling mistakes as well.

This parameter is optional; by default `codespell` will only check the file contents.

```yml
uses: codespell-project/actions-codespell@v1
with:
  check_filenames: true
```

### Parameter: check_hidden

If set, check hidden files (those starting with ".") for spelling mistakes as well.

This parameter is optional; by default `codespell` will not check hidden files.

```yml
uses: codespell-project/actions-codespell@v1
with:
  check_hidden: true
```

### Parameter: exclude_file

File with lines that should not be checked for spelling mistakes.

This parameter is optional; by default `codespell` will check all lines.

```yml
uses: codespell-project/actions-codespell@v1
with:
  exclude_file: src/foo
```

### Parameter: skip

Comma-separated list of files to skip (it accepts globs as well).

This parameter is optional; by default `codespell` won't skip any files.

```yml
uses: codespell-project/actions-codespell@v1
with:
  skip: foo,bar
```

### Parameter: builtin

Comma-separated list of builtin dictionaries to use.

This parameter is optional; by default `codespell` will use its default selection of built in dictionaries.

```yml
uses: codespell-project/actions-codespell@v1
with:
  builtin: clear,rare
```

### Parameter: ignore_words_file

File that contains words which will be ignored by `codespell`. File must contain one word per line.
Words are case sensitive based on how they are written in the dictionary file.

This parameter is optional; by default `codespell` will check all words for typos.

```yml
uses: codespell-project/actions-codespell@v1
with:
  ignore_words_file: .codespellignore
```

### Parameter: ignore_words_list

Comma-separated list of words which will be ignored by `codespell`.
Words are case sensitive based on how they are written in the dictionary file.

This parameter is optional; by default `codespell` will check all words for typos.

```yml
uses: codespell-project/actions-codespell@v1
with:
  ignore_words_list: abandonned,ackward
```

### Parameter: uri_ignore_words_list

Comma-separated list of words which will be ignored by `codespell` in URIs and emails only.
Words are case sensitive based on how they are written in the dictionary file.
If set to "*", all misspelling in URIs and emails will be ignored.

This parameter is optional; by default `codespell` will check all URIs and emails for typos.

```yml
uses: codespell-project/actions-codespell@v1
with:
  uri_ignore_words_list: abandonned
```

### Parameter: path

Indicates the path to run `codespell` in.
This can be useful if your project has code you don't want to spell check for some reason.

This parameter is optional; by default `codespell` will run on your whole repository.

```yml
uses: codespell-project/actions-codespell@v1
with:
  path: src
```

### Parameter: only_warn

Only warn about problems.
All errors and warnings are annotated in Pull Requests, but it will act like everything was fine anyway.
(In other words, the exit code is always 0.)

This parameter is optional; setting this to any value will enable it.

```yml
uses: codespell-project/actions-codespell@v1
with:
  only_warn: 1
```
