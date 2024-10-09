FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /opt

COPY . /opt/status-page

RUN chmod +x /opt/status-page/upgrade.sh

RUN pip install --upgrade pip

EXPOSE 8000

RUN cp /opt/status-page/contrib/gunicorn.py /opt/status-page/gunicorn.py

RUN cp -v /opt/status-page/contrib/*.service /etc/systemd/system/

CMD ["bash", "-c", "cd status-page && ./upgrade.sh && cd statuspage && source /opt/status-page/venv/bin/activate && gunicorn --bind 0.0.0.0:8000 statuspage.wsgi:application"]

