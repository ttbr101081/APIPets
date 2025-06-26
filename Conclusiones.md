# Concluciones 
Durante la ejecución de las pruebas automatizadas en Karate, se observó que el API de búsqueda por estado no retorna todos los items esperados. Al realizar una comparación cruzada mediante la búsqueda individual por ID, se verificó que los datos (nombre del estado e ID) sí cumplen con los cambios realizados, lo que sugiere un posible problema en la paginación o filtrado del endpoint de búsqueda general.

Además, se identificó que bajo condiciones de consumo repetitivo o alto volumen de peticiones consecutivas, los servicios presentan inestabilidad, llegando incluso a caer o devolver respuestas de error. Esto indica que sería necesario revisar la capacidad del sistema para manejar cargas sostenidas y considerar ajustes en términos de escalabilidad, caché o límites de tasa de consumo.

En base a estos hallazgos, se recomienda realizar una revisión técnica del endpoint de búsqueda por estado y evaluar pruebas de estrés adicionales para garantizar la disponibilidad y estabilidad del API bajo diferentes escenarios de uso.


