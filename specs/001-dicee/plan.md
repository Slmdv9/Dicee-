# Plan 001: rediseño dinámico de Dicee+

## Objetivo y principios de decisión

Este plan convierte la especificación 001 en una propuesta implementable para
la experiencia de uno y dos dados. Se mantiene Flutter, Dart, Material 3, los
assets existentes y el estado local de cada página. Las decisiones priorizan
claridad visual, animación perceptible, accesibilidad y pruebas estables.

## Cambios de diseño

### 1. Sistema visual Material 3 expresivo

- Adoptar una jerarquía de superficies con fondo, contenedor principal del
  dado, resultado y acción primaria claramente diferenciados.
- Usar el `ColorScheme` existente como base, con una paleta de acento más
  intencionada para estados seleccionados, activos y de interacción.
- Mantener variantes claro y oscuro con contraste equivalente y una identidad
  común.
- **Justificación:** aumenta la legibilidad y el impacto visual sin abandonar
  Material 3 ni introducir una librería de diseño nueva.
- **Cubre:** RF-1, RF-7.

### 2. Navegación y jerarquía de acciones

- Mantener los dos modos actuales y hacer más evidente el modo seleccionado.
- Dar al lanzamiento una única acción primaria, visible y con estado ocupado
  durante la tirada.
- Mostrar el resultado como el foco principal de cada modo, con separación
  suficiente entre dados en el modo de dos dados.
- **Justificación:** conserva el modelo mental actual y reduce la ambigüedad
  sobre qué acción inicia una tirada.
- **Cubre:** RF-1, RF-4, RF-7.

### 3. Presentación del dado

- Mantener `AnimatedDice` como frontera de presentación reutilizable para ambos
  modos.
- Añadir una composición visual alrededor del asset actual para reforzar
  profundidad, estado activo y resultado final sin sustituir la correspondencia
  entre valor y asset.
- Asegurar que el modo de dos dados conserve dos focos visuales distinguibles.
- **Justificación:** reutiliza el límite arquitectónico existente y evita
  duplicar la lógica visual entre páginas.
- **Cubre:** RF-2, RF-4, RF-5, RF-7.

### 4. Animación del lanzamiento

- Modelar la tirada como tres estados observables: disponible, girando y
  resultado estable.
- Iniciar un giro reconocible de 800 ms y resolver después el resultado final
  generado.
- En el modo de dos dados, coordinar ambos dados dentro de la misma tirada sin
  mezclar sus valores.
- **Justificación:** una secuencia explícita evita resultados intermedios
  ambiguos y hace verificable el inicio, la duración y la finalización.
- **Cubre:** RF-2, RF-3, RF-4.

### 5. Adaptación a movimiento reducido

- Consultar la preferencia de accesibilidad del sistema antes de elegir la
  transición.
- Con movimiento reducido, reemplazar el giro completo por una transición
  atenuada que conserve el cambio de estado y el resultado final.
- Mantener el control y el resultado comprensibles sin depender del movimiento.
- **Justificación:** satisface accesibilidad sin crear una ruta visual separada
  ni añadir dependencias.
- **Cubre:** RF-6, RF-2.

### 6. Layout adaptable

- Diseñar el contenido para tamaños compactos y amplios, manteniendo los dados
  dentro del área visible y evitando solapamientos.
- Conservar la navegación y la acción primaria accesibles en orientaciones
  compatibles.
- **Justificación:** las restricciones de espacio deben resolverse con el
  layout nativo de Flutter, no con tamaños fijos por plataforma.
- **Cubre:** RF-7, RF-1, RF-4.

## Decisiones técnicas justificadas

### Estado local y frontera de animación

La coordinación de `isRolling`, el resultado pendiente y la recuperación del
control permanecerá en cada página, mientras `AnimatedDice` recibirá el valor,
el estado visual y la preferencia de movimiento. Esto conserva la separación
`app`/`pages`/`widgets` y permite que cada modo sea independiente.

- **Alternativa descartada:** introducir Provider, Riverpod, Bloc u otro gestor
  global. Añadiría complejidad y contradice la constitución cuando el estado no
  se comparte entre páginas.
- **Cubre:** RF-3, RF-4, RF-6.

### Animación con APIs nativas de Flutter

La animación se resolverá con APIs de animación y composición ya disponibles en
Flutter, con una duración nominal de 800 ms y un estado de finalización explícito.

- **Alternativa descartada:** incorporar una librería de animación o un motor 3D.
  No es necesario para un giro bidimensional perceptible y ampliaría el stack,
  la superficie de pruebas y el riesgo multiplataforma.
- **Cubre:** RF-2, RF-3, RF-6, RF-7.

### Resultado generado antes de la transición

Cada tirada generará sus valores finales una sola vez al comenzar y la
animación presentará ese resultado al terminar. Los valores seguirán siendo
enteros del 1 al 6.

- **Alternativa descartada:** cambiar aleatoriamente la cara visible durante
  cada fotograma. Haría difícil garantizar el resultado final y produciría
  tests frágiles.
- **Cubre:** RF-2, RF-4, RF-5 y la regla constitucional de tests estables.

### Assets existentes como fuente visual

Se conservarán los assets claro/oscuro actuales y su correspondencia con los
valores. El rediseño añadirá composición y estados alrededor de ellos, sin
reemplazar el catálogo de seis caras.

- **Alternativa descartada:** migrar a dados vectoriales, 3D o generados en
  tiempo de ejecución. No aporta valor proporcional y puede romper la
  correspondencia visual ya establecida.
- **Cubre:** RF-5, RF-1, RF-7.

### Dependencias y plataforma

No se añadirá ninguna dependencia. Se mantendrán Material 3, los runners
Flutter existentes y el soporte de web, Android, iOS, Linux, macOS y Windows
según las capacidades disponibles de cada entorno.

- **Alternativa descartada:** adoptar un kit visual externo o un paquete de
  accesibilidad específico. La plataforma ya proporciona las primitivas
  necesarias y la constitución exige justificar cualquier dependencia nueva.
- **Cubre:** RF-1, RF-6, RF-7.

### Feedback no visual

No se añadirá sonido, háptica ni permisos nuevos; la confirmación de la acción
será exclusivamente visual y semántica.

- **Alternativa descartada:** añadir vibración o efectos de sonido para reforzar
  el lanzamiento. Está explícitamente fuera de alcance y complicaría la
  paridad entre plataformas.
- **Cubre:** RF-2, RF-6, RF-7.

## Estrategia de tests

### Pruebas widget de la experiencia

- Verificar que los dos modos se muestran, que el modo seleccionado es
  distinguible y que la acción primaria tiene una etiqueta comprensible.
  **Cubre:** RF-1, RF-4, RF-6.
- Verificar que una tirada entra en estado girando, mantiene el control
  bloqueado y vuelve a disponible al finalizar la animación de 800 ms.
  **Cubre:** RF-2, RF-3.
- Verificar que los toques repetidos durante la animación no crean tiradas
  adicionales y que una reconstrucción recupera el control.
  **Cubre:** RF-3.
- Verificar que los modos conservan estados independientes y que el modo de
  dos dados muestra dos resultados finales distinguibles.
  **Cubre:** RF-4.
- Verificar que los valores expuestos permanecen entre 1 y 6 y que el asset
  utilizado corresponde al tema activo, sin fijar un resultado aleatorio
  concreto.
  **Cubre:** RF-5.
- Verificar etiquetas semánticas, contraste revisable y transición atenuada al
  activar movimiento reducido.
  **Cubre:** RF-6.
- Renderizar la experiencia con restricciones compactas y amplias para detectar
  recortes, solapamientos o controles inaccesibles.
  **Cubre:** RF-7.

### Validación de calidad

- Ejecutar `flutter analyze` y resolver cualquier incidencia introducida.
  **Cubre:** todos los RF.
- Ejecutar `flutter test` con pruebas deterministas y sin depender de valores
  aleatorios concretos.
  **Cubre:** todos los RF relacionados con comportamiento.
- Revisar manualmente tema claro, tema oscuro, un dado, dos dados y movimiento
  reducido en al menos un destino Flutter disponible.
  **Cubre:** RF-1, RF-2, RF-4, RF-6, RF-7.

## Secuencia de implementación

1. Ajustar la jerarquía visual global y los estados de navegación. **Cubre:** RF-1, RF-7.
2. Definir la máquina de estados de tirada y el bloqueo de interacción por modo.
   **Cubre:** RF-2, RF-3, RF-4.
3. Integrar el giro de 800 ms y la variante de movimiento reducido en el límite
   visual del dado. **Cubre:** RF-2, RF-5, RF-6.
4. Adaptar layout, semántica y presentación del modo de dos dados. **Cubre:** RF-4, RF-6, RF-7.
5. Añadir o actualizar las pruebas widget y ejecutar las validaciones finales.
   **Cubre:** RF-1 a RF-7.

## Límites y criterios de salida

- No se implementan sonido, háptica, persistencia, backend, historial,
  autenticación ni nuevas modalidades. **Cubre:** RF-7.
- La implementación no cambia la separación de módulos ni introduce estado
  global. **Cubre:** RF-3, RF-4.
- El plan se considera satisfecho cuando cada RF tiene al menos una prueba o
  revisión verificable, las pruebas son estables y `flutter analyze` y
  `flutter test` pasan. **Cubre:** RF-1 a RF-7.
