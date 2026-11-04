FROM python:3.15-alpine@sha256:20a82dbc2783112ddb91d1534603f802d222a3e63e593cd002eb2ac534e70211

COPY LICENSE \
        README.md \
        entrypoint.sh \
        codespell-problem-matcher/codespell-matcher.json \
        requirements.txt \
        /code/

RUN pip install --no-cache-dir --require-hashes -r /code/requirements.txt

ENTRYPOINT ["/code/entrypoint.sh"]
CMD []
