# set environment variables
ARG PYTHONDONTWRITEBYTECODE=1
ARG PYTHONUNBUFFERED=1
ARG HOME_DIR=/app

# ----------- Base image ------------
FROM python:3.8-slim AS base

ARG PYTHONDONTWRITEBYTECODE
ARG PYTHONUNBUFFERED
ARG HOME_DIR
ENV PYTHONDONTWRITEBYTECODE $PYTHONDONTWRITEBYTECODE
ENV PYTHONUNBUFFERED $PYTHONUNBUFFERED
ENV HOME_DIR $HOME_DIR

#RUN apt-get -y update \
#    && apt-get install -y \
#    vim

RUN mkdir -p $HOME_DIR
WORKDIR $HOME_DIR

COPY ./app .
RUN pip install --upgrade pip \
  && pip install --no-cache-dir -r requirements.txt \
  && rm -rf /root/.cache/pip

# ----------- Release image ------------
FROM python:3.8-slim AS release
ARG PYTHONDONTWRITEBYTECODE
ARG PYTHONUNBUFFERED
ARG HOME_DIR
ENV PYTHONDONTWRITEBYTECODE $PYTHONDONTWRITEBYTECODE
ENV PYTHONUNBUFFERED $PYTHONUNBUFFERED
ENV HOME_DIR $HOME_DIR

#COPY --from=base /usr/bin/vim /usr/bin/vim
COPY --from=base ./usr/local/lib/python3.8/site-packages /usr/local/lib/python3.8/site-packages
COPY --from=base /usr/local/bin/uvicorn /usr/local/bin/uvicorn
COPY --from=base /usr/local/bin/pytest /usr/local/bin/pytest
COPY --from=base /usr/local/bin/coverage /usr/local/bin/coverage

#RUN apt-get -y update \
#    && apt-get install -y \
#    vim

WORKDIR ${HOME_DIR}
COPY --from=base ./app .
#RUN pip install --upgrade pip \
# && pip install --no-cache-dir -r requirements.txt \
# && rm -rf /root/.cache/pip

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

EXPOSE 80

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
