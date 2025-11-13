# Imagen base
FROM python:3.11-slim

# Evitar buffer en logs
ENV PYTHONUNBUFFERED=1

# Crear directorio
WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    default-mysql-client \
    libmysqlclient-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copiar requirements
COPY requirements.txt .

# Instalar dependencias Python
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copiar todo el proyecto
COPY . .

# Exponer puerto para Django
EXPOSE 8000

# Comando de ejecución
CMD ["gunicorn", "videla.wsgi:application", "--bind", "0.0.0.0:8000"]
