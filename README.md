# E-commerce Concept

<div style="display: flex; gap: 10px; align-items: center;">

  <img src="https://github.com/user-attachments/assets/6ee31570-3ffd-4feb-b161-5b819d37e455" alt="Simulator Screenshot - iPhone SE (3rd generation) - 2024-09-20 at 00 57 59" width="200"/>

  <img src="https://github.com/user-attachments/assets/58ba8c46-9bf5-4fb3-a5da-6bffd98556ca" alt="Simulator Screenshot - iPhone SE (3rd generation) - 2024-09-20 at 00 58 19" width="200"/>

## Video
https://github.com/user-attachments/assets/b5300fce-73a7-47e7-8d1b-2974ad4df2e9


## Descripción
Este proyecto es una aplicación de e-commerce desarrollada en Flutter que permite a los usuarios explorar productos, ver detalles específicos, y realizar acciones como agregar productos al carrito. La aplicación sigue la arquitectura limpia (Clean Architecture) para mantener un código modular, fácil de mantener y escalable.

## Flutter y Dependencias


### Versión de Flutter
- **SDK de Flutter:** `>=3.4.1 <4.0.0`
- **Versión actual del proyecto:** 1.0.0+1

### Dependencias Principales

#### Framework y Utilidades
- **flutter:** SDK de Flutter.
- **cupertino_icons:** ^1.0.6 - Conjunto de iconos de iOS.
- **google_fonts:** ^6.2.1 - Fuentes de Google para una mejor tipografía.
- **responsive_framework:** ^1.4.0 - Herramienta para crear interfaces de usuario responsivas.
- **flutter_bloc:** ^8.1.6 - Manejo de estado con Bloc.
- **get_it:** ^7.7.0 - Inyección de dependencias.

#### Manejo de Datos y Lógica
- **async:** ^2.11.0 - Soporte para programación asincrónica.
- **equatable:** ^2.0.5 - Comparación de objetos.
- **dio:** ^5.7.0 - Cliente HTTP para peticiones a la API.
- **json_annotation:** ^4.9.0 - Anotaciones para la serialización JSON.
- **flutter_secure_storage:** ^4.2.1 - Almacenamiento seguro para datos sensibles.

#### Manejo de Errores y Loggers
- **talker:** ^4.4.1 - Logger de aplicaciones para Flutter.
- **talker_dio_logger:** ^4.4.1 - Logger para peticiones HTTP con Dio.
- **talker_bloc_logger:** ^4.4.1 - Logger para manejo de estados con Bloc.

#### Concurrencia y Transformaciones de Streams
- **stream_transform:** ^2.1.0 - Transformaciones avanzadas de streams.
- **bloc_concurrency:** ^0.2.5 - Concurrencia para eventos de Bloc.

#### UI y Widgets Adicionales
- **cached_network_image:** ^3.4.1 - Carga de imágenes con cache.
- **flutter_rating_bar:** ^4.0.1 - Barra de calificación de estrellas.

### Dependencias para Pruebas
- **flutter_test:** SDK de Flutter - Herramientas de prueba para Flutter.
- **flutter_lints:** ^3.0.0 - Reglas de lint para mantener la calidad del código.
- **json_serializable:** ^6.8.0 - Generación automática de código para JSON.
- **build_runner:** ^2.4.11 - Utilidad para generar código automáticamente.
- **mockito:** ^5.4.4 - Herramienta para la creación de mocks en tests.
- **bloc_test:** ^9.1.7 - Herramientas de prueba para Bloc.

## Documentación de Pruebas Realizadas

### 1. Pruebas Unitarias
Se realizaron pruebas unitarias para verificar la lógica de negocio, asegurando que los repositorios y servicios de datos funcionen correctamente con diferentes escenarios, incluyendo manejo de errores.

### 2. Pruebas de Widgets
Las pruebas de widgets se llevaron a cabo para validar la correcta renderización y funcionamiento de componentes de UI, como listas de productos y detalles de productos. Se utilizaron `WidgetTester` y `Mocktail` para simular interacciones y verificar la navegación entre vistas.

### 3. Pruebas de Bloc
Se probaron los BLoCs para asegurar que manejen los eventos correctamente y actualicen el estado de acuerdo con las acciones del usuario, como refrescar la lista de productos o cargar más elementos al hacer scroll.

### Resultados Obtenidos
- Todos los tests unitarios y de widgets se ejecutaron con éxito, asegurando un comportamiento estable y predecible de la aplicación.
- No se encontraron errores críticos durante las pruebas, y los casos de uso comunes fueron manejados adecuadamente.
- Los componentes de la UI se renderizan como se espera y responden correctamente a las acciones del usuario.

## Cómo Ejecutar las Pruebas
Para ejecutar todas las pruebas, sigue estos pasos:

1. Clona este repositorio y navega al directorio del proyecto.
2. Asegúrate de tener Flutter instalado y configurado correctamente.
3. Abre una terminal y ejecuta el siguiente comando:

   ```bash
   flutter test
    ```
Esto ejecutará todas las pruebas unitarias y de widgets dentro de la carpeta test.

## Cómo Ejecutar la Aplicación
```bash
   flutter run --debug -t lib/main.dart
```

Esto ejecutará la apliación, no se olvide de tener un emulador abierto o el ceclular conectado.

## Estructura del proyecto
```plaintext
lib/
│
├── app_config/
│   ├── error/
│   │   └── failure.dart
│   │
│   ├── http_client/
│   │   ├── api_client.dart
│   │   └── api_client_impl.dart
│   │
│   ├── injector/
│   │   └── injector.dart
│   │
│   ├── style/
│   │   └── app_palette.dart
│   │
│   └── utils/
│       ├── test_helper.dart
│       └── my_app.dart
│
├── features/
│   └── product/
│       ├── data/
│       │   ├── datasource/
│       │   ├── models/
│       │   └── repositories/
│       │
│       ├── domain/
│       │   ├── entities/
│       │   └── repositories/
│       │
│       └── ui/
│           ├── bloc/
│           ├── pages/
│           ├── view/
│           └── widgets/
│
└── main.dart
```
Use una arquitectura limpia con 3 capaz, pero, sin casos de usos para ganar tiempo. La carpeta de ***Test*** presenta la misma estructura.

## Reporte WakaTime
Reporte de las horas trabajadas en el proyecto.
<img width="800" alt="Screenshot 2024-09-20 at 1 01 18 AM" src="https://github.com/user-attachments/assets/667e4bf3-3bc2-4885-8c55-f4e71e908cfc">

## Video de la evolución del trabajo
#### Primer fetch de productos
https://github.com/user-attachments/assets/82fd5ff0-12e4-4444-8734-6148d6f715e0
### Comenzado la pantalla de detalle
https://github.com/user-attachments/assets/bfde3fb7-e0d2-4de4-acdc-edf3cf311944
### Diseño de inspiración
![detalle](https://github.com/user-attachments/assets/b299c0f5-d87d-4e9a-a12c-34c9cc31d15c)









