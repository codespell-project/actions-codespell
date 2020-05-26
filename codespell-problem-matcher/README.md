# codespell-problem-matcher

This problem matcher lets you show errors from `codespell` as annotation in
GitHub Actions.

Based on [korelstar](https://github.com/korelstar)'s [xmllint-problem-matcher](https://github.com/korelstar/xmllint-problem-matcher).

## Inputs

No inputs are required.

## Outputs

No outputs are generated apart from a configured problem matcher.

## Usage

Add the step to your workflow, before `codespell` is called.

```yaml
    - uses: codespell-project/codespell-problem-matcher@v1
```
