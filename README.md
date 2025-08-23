# Codespell with GitHub Actions -- including annotations for Pull Requests

This GitHub Actions runs codespell over your code.
Any warnings or errors will be annotated in the Pull Request.

## Usage

```yml
uses: codespell-project/actions-codespell@v2
```

## Possible use for checking a pull request
```
# GitHub Action to automate the identification of common misspellings in text files.
# https://github.com/codespell-project/actions-codespell
# https://github.com/codespell-project/codespell

name: Codespell
on: 
  pull_request_target:

jobs:
  codespell:
    name: Check for spelling errors
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2

    - name: Get changed files
      id: changed-files
      uses: tj-actions/changed-files@v12.2

    - name: Get the latest dictionary
      run: |
        wget https://raw.githubusercontent.com/codespell-project/codespell/master/codespell_lib/data/dictionary.txt

    - name: Get the latest rare dictionary
      run: |
        wget https://raw.githubusercontent.com/codespell-project/codespell/master/codespell_lib/data/dictionary_rare.txt    

    - uses: codespell-project/actions-codespell@master
      with:
        dictionary: dictionary.txt,dictionary_rare.txt
        path: ${{ steps.changed-files.outputs.all_changed_files }}
```



### Parameter: check_filenames

If set, check file names for spelling mistakes as well.

This parameter is optional; by default `codespell` will only check the file contents.

```yml
uses: codespell-project/actions-codespell@v2
with:
  check_filenames: true
```

### Parameter: check_hidden

If set, check hidden files (those starting with ".") for spelling mistakes as well.

This parameter is optional; by default `codespell` will not check hidden files.

```yml
uses: codespell-project/actions-codespell@v2
with:
  check_hidden: true
```

### Parameter: exclude_file

File with lines that should not be checked for spelling mistakes.

This parameter is optional; by default `codespell` will check all lines.

```yml
uses: codespell-project/actions-codespell@v2
with:
  exclude_file: src/foo
```

### Parameter: skip

Comma-separated list of files to skip (it accepts globs as well).

This parameter is optional; by default `codespell` won't skip any files.

```yml
uses: codespell-project/actions-codespell@v2
with:
  skip: foo,bar
```

### Parameter: dictionary

Comma-separated list of custom dictionaries to use.
This parameter is optional; by default `codespell` will use the builtin dictionaries.

```
uses: codespell-project/actions-codespell@master
with:
  dictionary: dictionary.txt,dictionary2.txt
```

### Parameter: builtin

Comma-separated list of builtin dictionaries to use.

This parameter is optional; by default `codespell` will use its default selection of built in dictionaries.

```yml
uses: codespell-project/actions-codespell@v2
with:
  builtin: clear,rare
```

### Parameter: ignore_words_file

File that contains words which will be ignored by `codespell`. File must contain one word per line.
Words are case sensitive based on how they are written in the dictionary file.

This parameter is optional; by default `codespell` will check all words for typos.

```yml
uses: codespell-project/actions-codespell@v2
with:
  ignore_words_file: .codespellignore
```

### Parameter: ignore_words_list

Comma-separated list of words which will be ignored by `codespell`.
Words are case sensitive based on how they are written in the dictionary file.

This parameter is optional; by default `codespell` will check all words for typos.

```yml
uses: codespell-project/actions-codespell@v2
with:
  ignore_words_list: abandonned,ackward
```

### Parameter: uri_ignore_words_list

Comma-separated list of words which will be ignored by `codespell` in URIs and emails only.
Words are case sensitive based on how they are written in the dictionary file.
If set to "*", all misspelling in URIs and emails will be ignored.

This parameter is optional; by default `codespell` will check all URIs and emails for typos.

```yml
uses: codespell-project/actions-codespell@v2
with:
  uri_ignore_words_list: abandonned
```

### Parameter: path

Indicates the path to run `codespell` in.
This can be useful if your project has code you don't want to spell check for some reason.

This parameter is optional; by default `codespell` will run on your whole repository.

```yml
uses: codespell-project/actions-codespell@v2
with:
  path: src
```

### Parameter: only_warn

Only warn about problems.
All errors and warnings are annotated in Pull Requests, but it will act like everything was fine anyway.
(In other words, the exit code is always 0.)

This parameter is optional; setting this to any value will enable it.

```yml
uses: codespell-project/actions-codespell@v2
with:
  only_warn: 1
```
