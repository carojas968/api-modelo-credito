# -----------------------------------------------------------
# 1) Imagen base: Python oficial, ligera (Debian slim) 3.11
# -----------------------------------------------------------
FROM python:3.11-slim

# -----------------------------------------------------------
# 2) Carpeta de trabajo dentro del contenedor
#    Todo lo que copies irá a /app
# -----------------------------------------------------------
WORKDIR /app

# -----------------------------------------------------------
# 3) Copiar el listado de dependencias primero.
#    De esta manera, Docker aprovechará la capa cacheada
#    cuando solo cambies código y no requirements.txt
# -----------------------------------------------------------
COPY requirements.txt .

# -----------------------------------------------------------
# 4) Instalación de dependencias.
#    --no-cache-dir evita que pip guarde cachés ≈ imagen más pequeña.
# -----------------------------------------------------------
RUN pip install --no-cache-dir -r requirements.txt

# -----------------------------------------------------------
# 5) Copiar el resto del proyecto: app.py, modelo_hgb.joblib, etc.
# -----------------------------------------------------------
COPY . .

# -----------------------------------------------------------
# 6) Exponer el puerto interno (opcional, Información)
#    Uvicorn escuchará en 8080 dentro del contenedor.
# -----------------------------------------------------------
EXPOSE 8080

# -----------------------------------------------------------
# 7) Comando por defecto.
#    • --host 0.0.0.0   => accesible desde fuera del contenedor
#    • --port 8080      => el puerto expuesto arriba
# -----------------------------------------------------------
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]