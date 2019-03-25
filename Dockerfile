FROM alpine:3.7 AS base
WORKDIR /src
RUN apk add --update python py-pip
COPY app.py /src
COPY buzz /src/buzz
EXPOSE 5000


FROM base AS tests
LABEL image=test
COPY requirements/requirements_test.txt /src/requirements/requirements.txt
RUN pip install -r requirements.txt
RUN python -m pytest -v tests/test_generator.py


FROM base AS deploy
LABEL image=deploy
COPY requirements/requirements.txt /src/requirements/txt
RUN pip install -r requirement.txt
CMD python /src/app.py