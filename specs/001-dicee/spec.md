# Especificación 001: rediseño dinámico de Dicee+

## Contexto y objetivo

Dicee+ permite lanzar uno o dos dados mediante dos modos accesibles desde la
navegación principal. La primera modificación modernizará toda la experiencia
visual con una dirección Material 3 expresiva, una jerarquía más clara y una
animación de giro que haga evidente la acción de lanzar. El resultado final
deberá ser atractivo, fluido, comprensible y usable con movimiento reducido.

## Usuarios

- Personas que lanzan un dado para una decisión o actividad informal.
- Personas que lanzan dos dados y necesitan distinguir ambos resultados.
- Personas que usan Dicee+ en web o en plataformas Flutter compatibles.
- Personas que prefieren o necesitan reducir el movimiento visual.

## Historias de usuario

- Como usuario, quiero reconocer rápidamente los dos modos para elegir entre
  lanzar uno o dos dados.
- Como usuario, quiero que la interfaz tenga una apariencia actual y dinámica
  para entender mejor la acción principal.
- Como usuario, quiero ver el dado girar durante el lanzamiento para percibir
  que la acción se está ejecutando.
- Como usuario, quiero consultar con claridad el resultado final de cada dado.
- Como usuario, quiero evitar lanzamientos accidentales mientras una tirada
  está en curso.
- Como usuario con movimiento reducido, quiero una transición atenuada sin
  perder información ni control.

## Requisitos funcionales

### RF-1. Dirección visual Material 3 expresiva

La aplicación debe actualizar navegación, fondos, superficies, botones,
tipografía y estados claro/oscuro con una dirección visual coherente, dinámica
y más vistosa, manteniendo Material 3.

Criterios de aceptación:

- Los dos modos comparten una jerarquía visual coherente.
- Los controles de lanzamiento se distinguen claramente del contenido.
- Los estados claro y oscuro mantienen legibilidad y contraste suficientes.
- La navegación principal comunica cuál de los dos modos está seleccionado.

### RF-2. Animación visible del giro

Cada dado debe mostrar un giro reconocible durante aproximadamente 800 ms y
terminar mostrando el resultado generado.

Criterios de aceptación:

- Al lanzar, el dado inicia una transición de giro visible.
- La transición termina mostrando exactamente el resultado de esa tirada.
- El resultado permanece estable después de finalizar la animación.
- La animación no depende de sonido ni háptica.

### RF-3. Bloqueo y recuperación durante la tirada

La aplicación debe ignorar nuevos lanzamientos mientras una animación está en
curso y recuperar el control de forma segura al terminar.

Criterios de aceptación:

- Los toques repetidos durante la animación no generan tiradas adicionales.
- El control vuelve a estar disponible al finalizar la transición.
- Una reconstrucción de la vista no deja el control bloqueado indefinidamente.
- El último resultado válido se conserva si la vista se reconstruye durante la tirada.

### RF-4. Independencia de los modos

El modo de un dado y el modo de dos dados deben mantener sus resultados y
animaciones de forma independiente.

Criterios de aceptación:

- Lanzar en un modo no cambia el resultado mostrado en el otro.
- El modo de dos dados puede animar ambos dados y mostrar sus resultados finales.
- Cambiar de pestaña no mezcla estados entre modos.

### RF-5. Valores y assets válidos

Cada resultado debe mantenerse dentro del rango entero del 1 al 6 y utilizar el
asset correspondiente al tema activo.

Criterios de aceptación:

- Ningún resultado visible queda fuera del rango 1–6.
- Cada valor válido tiene una representación visual asociada.
- Las variantes claro y oscuro conservan la correspondencia entre valor y asset.

### RF-6. Accesibilidad y movimiento reducido

La interfaz debe conservar contraste, etiquetas semánticas y una alternativa de
transición atenuada cuando el sistema solicite reducir movimiento.

Criterios de aceptación:

- Los controles y modos tienen nombres accesibles que describen su función.
- La información del resultado no depende exclusivamente del movimiento.
- Con movimiento reducido, la transición evita el giro completo y conserva el
  resultado final y el estado del control.

### RF-7. Adaptabilidad y ausencia de multimedia adicional

La experiencia debe mantenerse usable en tamaños y orientaciones compatibles,
sin incorporar sonido, háptica ni nuevas modalidades de dados.

Criterios de aceptación:

- Los dados, controles y navegación siguen siendo utilizables en tamaños reducidos.
- El contenido no queda cortado ni se superpone en orientaciones compatibles.
- La interacción no solicita permisos ni reproduce audio o vibraciones.

## Requisitos no funcionales

- Mantener Flutter, Dart, Material 3 y las dependencias existentes.
- No añadir dependencias salvo que una necesidad técnica quede justificada.
- Mantener el estado local de cada página y la separación actual entre `app`,
  `pages` y `widgets`.
- Mantener una animación fluida, sin saltos perceptibles durante una tirada.
- Mantener la aplicación usable con teclado, lector de pantalla y movimiento reducido.
- Mantener los textos y la documentación del proyecto en inglés cuando formen
  parte de la implementación o de las guías del repositorio.

## Casos límite

- El usuario pulsa varias veces el control durante una animación.
- La vista se reconstruye mientras el dado está girando.
- El usuario cambia de tema durante o inmediatamente después de una tirada.
- El usuario cambia de pestaña mientras una tirada está en curso.
- El espacio disponible es reducido o cambia la orientación de la pantalla.
- El sistema solicita movimiento reducido antes de iniciar una tirada.
- Un valor interno inválido o un asset ausente: se mantiene fuera de alcance y
  no se define una recuperación específica en esta iteración.

## Fuera de alcance

- Sonido, háptica y efectos multimedia adicionales.
- Backend, red, persistencia, historial o sincronización de resultados.
- Autenticación, perfiles y permisos nuevos.
- Nuevas modalidades o dados con más de seis caras.
- Sustitución del stack Flutter o incorporación de un paquete de gestión de estado.
- Corrección específica de assets inexistentes o dañados.

## Criterios de finalización

- Todos los RF-1 a RF-7 tienen implementación verificable y criterios satisfechos.
- Las pruebas widget cubren navegación, controles, giro, bloqueo y recuperación.
- Las pruebas cubren etiquetas accesibles y movimiento reducido.
- Las pruebas verifican estados estables y valores válidos sin fijar resultados
  aleatorios concretos.
- `flutter analyze` finaliza sin incidencias.
- `flutter test` finaliza con todas las pruebas correctas.
- La interfaz se revisa en tema claro, tema oscuro, modo de un dado y modo de
  dos dados en al menos un destino Flutter compatible.

## Dudas abiertas

No hay dudas abiertas. Si surgiera alguna durante la implementación, deberá
registrarse con la etiqueta `[NECESITA ACLARACIÓN]`. La duración inicial de la
animación queda fijada en 800 ms, dentro del rango acordado de 700–1000 ms. Los
errores de assets quedan explícitamente fuera de alcance en esta iteración.
