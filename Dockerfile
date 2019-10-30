FROM python:3.8-alpine

COPY LICENSE \
        README.md \
        entrypoint.sh \
        flake8-matcher.json \
        requirements.txt \
        /code/

RUN pip install -r /code/requirements.txt

ENTRYPOINT ["/code/entrypoint.sh"]
CMD []
