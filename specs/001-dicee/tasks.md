# Tareas 001: rediseño dinámico de Dicee+

Las tareas están ordenadas por dependencia. Cada tarea está acotada a un máximo
aproximado de 20–30 minutos y debe conservar el stack Flutter existente.

## Preparación y diseño visual

- [x] **T-01 (20 min): establecer la referencia visual y los estados de pantalla.**
  Revisar los estados disponible, girando, resultado estable, tema claro, tema
  oscuro y movimiento reducido.
  **Cubre:** RF-1, RF-2, RF-3, RF-6, RF-7.
  **Hecho cuando:** existe una lista de estados y cada uno tiene una decisión
  visual verificable contra la especificación.
  **Resultado:** [`visual-states.md`](visual-states.md) documenta los seis estados
  y su verificación; T2 queda pendiente.

- [x] **T-02 (25 min): definir la jerarquía Material 3 compartida.**
  Aplicar roles coherentes para fondo, superficie del dado, resultado, acción
  primaria, selección y estado ocupado en ambos modos.
  **Cubre:** RF-1, RF-7.
  **Hecho cuando:** tema claro y oscuro muestran la misma jerarquía, con
  contraste legible y una acción primaria distinguible.
  **Resultado:** `DiceeApp` centraliza `ColorScheme`, fondo, acción primaria,
  estado deshabilitado y selección de pestaña; los tests cubren ambos temas.

- [x] **T-03 (20 min): actualizar la navegación de los dos modos.**
  Hacer evidente la pestaña seleccionada y mantener nombres comprensibles para
  navegación y lanzamiento.
  **Cubre:** RF-1, RF-4, RF-6.
  **Hecho cuando:** cada modo puede identificarse visual y semánticamente sin
  depender del contenido del dado.
  **Resultado:** las pestañas muestran `One die` y `Two dice`, y cada modo
  expone una acción `Roll` descriptiva; las pruebas verifican texto y semántica.

- [x] **T-04 (25 min): rediseñar la composición del modo de un dado.**
  Priorizar el dado, el resultado y la acción primaria con espaciado adaptable.
  **Cubre:** RF-1, RF-7.
  **Hecho cuando:** el modo de un dado mantiene todos sus elementos visibles en
  tamaños compactos y amplios.
  **Resultado:** `OneDicePage` usa una composición responsive con `Card`,
  resultado explícito, `SafeArea` y scroll; T5 queda pendiente.

- [ ] **T-05 (25 min): rediseñar la composición del modo de dos dados.**
  Mantener dos focos visuales distinguibles, separación suficiente y una acción
  primaria compartida.
  **Cubre:** RF-1, RF-4, RF-7.
  **Hecho cuando:** ambos dados se distinguen sin solaparse y el resultado de
  cada uno puede consultarse por separado.

- [ ] **T-06 (25 min): enriquecer la presentación reutilizable del dado.**
  Añadir profundidad, estados activo/ocupado y resultado estable alrededor de
  los assets existentes sin cambiar la correspondencia de valores.
  **Cubre:** RF-1, RF-2, RF-5, RF-7.
  **Hecho cuando:** los dos modos reutilizan la misma presentación y los seis
  valores conservan su asset claro y oscuro correspondiente.

## Estado y animación

- [ ] **T-07 (25 min): definir los estados locales de una tirada.**
  Modelar disponible, girando y resultado estable dentro de cada página, con un
  resultado final generado una sola vez al comenzar.
  **Cubre:** RF-2, RF-3, RF-4, RF-5.
  **Hecho cuando:** una tirada tiene una transición de estados determinista y
  cada modo conserva su propio resultado válido entre 1 y 6.

- [ ] **T-08 (30 min): integrar el giro de 800 ms en el modo de un dado.**
  Mostrar un giro reconocible, resolver el resultado al finalizar y conservarlo
  estable después de la animación.
  **Cubre:** RF-2, RF-5.
  **Hecho cuando:** el modo de un dado muestra movimiento durante 800 ms y
  termina en el resultado generado sin cambiarlo después.

- [ ] **T-09 (30 min): coordinar el giro de los dos dados.**
  Aplicar la misma secuencia temporal al modo de dos dados sin mezclar sus
  valores ni perder la distinción visual entre ellos.
  **Cubre:** RF-2, RF-4, RF-5.
  **Hecho cuando:** los dos dados inician y terminan la tirada de forma
  coordinada y cada uno conserva un valor independiente entre 1 y 6.

- [ ] **T-10 (20 min): bloquear y recuperar la acción de lanzamiento.**
  Deshabilitar o ignorar toques durante el estado girando y restaurar el control
  al finalizar, incluyendo una reconstrucción de la vista.
  **Cubre:** RF-3.
  **Hecho cuando:** los toques repetidos no generan tiradas adicionales y el
  control vuelve a estar disponible tras una finalización normal o reconstrucción.

- [ ] **T-11 (20 min): aplicar movimiento reducido.**
  Seleccionar una transición atenuada cuando el sistema solicite reducir
  movimiento y conservar el resultado y el estado del control.
  **Cubre:** RF-2, RF-6.
  **Hecho cuando:** con movimiento reducido no se ejecuta el giro completo, pero
  el resultado final y la recuperación del control siguen siendo visibles.

## Adaptabilidad y accesibilidad

- [ ] **T-12 (25 min): ajustar el layout a tamaños y orientaciones compatibles.**
  Revisar restricciones compactas y amplias, evitando recortes, solapamientos y
  controles fuera del área utilizable.
  **Cubre:** RF-7, RF-1, RF-4.
  **Hecho cuando:** ambos modos se pueden usar en las restricciones compactas y
  amplias definidas sin contenido cortado ni superpuesto.

- [ ] **T-13 (25 min): completar semántica y contraste accesibles.**
  Añadir etiquetas comprensibles para modos, dados, resultados y acción
  primaria, y revisar que la información no dependa solo del movimiento.
  **Cubre:** RF-1, RF-6, RF-7.
  **Hecho cuando:** un lector de pantalla puede identificar modos, resultados y
  acción de lanzamiento, y los estados claro/oscuro mantienen contraste legible.

- [ ] **T-14 (15 min): verificar límites de alcance multimedia.**
  Confirmar que la interacción no introduce audio, vibración, permisos nuevos ni
  modalidades adicionales.
  **Cubre:** RF-2, RF-7.
  **Hecho cuando:** una revisión del cambio confirma que el feedback es visual y
  semántico exclusivamente.

## Tests deterministas

- [ ] **T-15 (20 min): actualizar la prueba de navegación y apariencia.**
  Cubrir la presencia de ambos modos, selección visible, acción primaria y
  estados de tema sin afirmar detalles aleatorios.
  **Cubre:** RF-1, RF-4, RF-6, RF-7.
  **Hecho cuando:** la prueba verifica los elementos estables de navegación,
  etiquetas y jerarquía principal.

- [ ] **T-16 (30 min): probar giro, duración y resultado estable.**
  Verificar el estado girando, la duración nominal de 800 ms y el resultado final
  sin fijar una cara aleatoria concreta.
  **Cubre:** RF-2, RF-5.
  **Hecho cuando:** la prueba demuestra el inicio, la finalización y la
  estabilidad posterior de la animación en ambos modos.

- [ ] **T-17 (25 min): probar bloqueo y recuperación.**
  Simular toques repetidos y una reconstrucción durante una tirada para asegurar
  que no se crean lanzamientos extra y que el control se recupera.
  **Cubre:** RF-3.
  **Hecho cuando:** la prueba cuenta una única tirada por interacción válida y
  confirma que el control vuelve a estar disponible.

- [ ] **T-18 (25 min): probar independencia y rango de valores.**
  Verificar que cambiar o lanzar un modo no modifica el otro y que los resultados
  permanecen entre 1 y 6 con assets acordes al tema.
  **Cubre:** RF-4, RF-5.
  **Hecho cuando:** la prueba confirma estados separados, rango válido y
  correspondencia claro/oscuro sin depender de un resultado concreto.

- [ ] **T-19 (25 min): probar accesibilidad, movimiento reducido y layout.**
  Revisar etiquetas, transición atenuada y renderizados en restricciones
  compactas y amplias.
  **Cubre:** RF-6, RF-7.
  **Hecho cuando:** las pruebas encuentran los nombres accesibles, omiten el giro
  completo con movimiento reducido y no detectan recortes ni solapamientos.

## Validación final

- [ ] **T-20 (20 min): ejecutar análisis y suite de tests.**
  Ejecutar `flutter analyze` y `flutter test`, corrigiendo únicamente problemas
  introducidos por esta modificación.
  **Cubre:** RF-1 a RF-7.
  **Hecho cuando:** ambos comandos terminan correctamente y las pruebas son
  deterministas.

- [ ] **T-21 (25 min): realizar revisión manual multiplataforma mínima.**
  Revisar tema claro, tema oscuro, un dado, dos dados, giro, bloqueo y movimiento
  reducido en al menos un destino Flutter disponible.
  **Cubre:** RF-1, RF-2, RF-3, RF-4, RF-6, RF-7.
  **Hecho cuando:** cada estado de aceptación se observa sin recortes,
  solapamientos ni bloqueos persistentes.

- [ ] **T-22 (20 min): comprobar alcance y documentación de la entrega.**
  Confirmar que no se añadieron dependencias, estado global, multimedia,
  persistencia, backend ni modalidades nuevas, y que la implementación sigue la
  constitución y esta especificación.
  **Cubre:** RF-1 a RF-7.
  **Hecho cuando:** la revisión final no encuentra cambios fuera de alcance y
  cada RF enlaza con al menos una tarea completada y una verificación.
