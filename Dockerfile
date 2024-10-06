FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY . /app/

RUN chmod +x /app/upgrade.sh

RUN pip install --upgrade pip

EXPOSE 8000

CMD ["bash", "-c", "/app/upgrade.sh && source /app/venv/bin/activate && gunicorn --bind 0.0.0.0:8000 statuspage.wsgi:application"]

