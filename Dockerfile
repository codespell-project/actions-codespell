FROM python:3.14-alpine@sha256:c6ead215bfd31f1e433d968853b7a769989117115b728874824e6c0a27cb96fc

COPY LICENSE \
        README.md \
        entrypoint.sh \
        codespell-problem-matcher/codespell-matcher.json \
        requirements.txt \
        /code/

RUN pip install --no-cache-dir --require-hashes -r /code/requirements.txt

ENTRYPOINT ["/code/entrypoint.sh"]
CMD []
