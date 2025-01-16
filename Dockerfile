FROM python:3.8-alpine

COPY LICENSE \
        README.md \
        entrypoint.sh \
        codespell-problem-matcher/codespell-matcher.json \
        requirements.txt \
        /code/

RUN pip install -r /code/requirements.txt \
    && addgroup -g 1000 codespell \
    && adduser -u 1000 -G codespell -s /bin/sh -D codespell

USER 1000

ENTRYPOINT ["/code/entrypoint.sh"]
CMD []
