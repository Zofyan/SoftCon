FROM alpine
RUN apk update
RUN apk add py-pip
RUN apk add musl-dev libpq-dev gcc
RUN apk add --no-cache python3-dev 
RUN pip install --upgrade pip
WORKDIR /app
COPY . /app
RUN pip --no-cache-dir install -r requirements.txt
CMD ["python3", "rest.py"]