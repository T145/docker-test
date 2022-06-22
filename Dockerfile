FROM python:3.8

RUN pip3 install --no-cache-dir --upgrade -e git+https://github.com/twintproject/twint.git@v2.1.21#egg=twint
