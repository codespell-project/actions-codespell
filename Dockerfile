FROM python:3.14-alpine@sha256:9e9fde4d32eedce0b661d9ab91e826b62dddf28e928c230ec55f1866cac66b01

COPY LICENSE \
        README.md \
        entrypoint.sh \
        codespell-problem-matcher/codespell-matcher.json \
        requirements.txt \
        /code/

RUN pip install --no-cache-dir --require-hashes -r /code/requirements.txt

ENTRYPOINT ["/code/entrypoint.sh"]
CMD []
