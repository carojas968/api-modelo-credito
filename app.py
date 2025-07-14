from fastapi import FastAPI
import joblib
import pandas as pd

# ➊ Carga una sola vez el modelo
modelo = joblib.load("modelo_hgb.joblib")

# ➋ Define el orden de las columnas (ajústalo a tu caso)
#columnas = ['edad', 'ingresos_mensuales', 'score_crediticio', 'es_cliente']
columnas = [ 'edad', 'ingresos_mensuales', 'score_crediticio','ingreso_por_edad', 'Score_Ingresos', 'region', 'justificacion']

app = FastAPI(title="API HistGradientBoosting", version="1.0")

@app.post("/predecir")
def predecir(datos: dict):
    df = pd.DataFrame([datos], columns=columnas)
    pred = int(modelo.predict(df)[0])
    proba = float(modelo.predict_proba(df)[0][1])
    return {"pred": pred, "proba": proba}