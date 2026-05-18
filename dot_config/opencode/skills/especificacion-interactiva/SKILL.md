---
name: especificacion-interactiva
description: Historias de usuario, especificacion funcional, asunciones y barra de progreso. Use ONLY when the user wants to convert a user story into a filled specification through interactive validation of non-technical or functional assumptions, preferably in Spanish.
---

# Especificacion Interactiva

Usa este skill solo cuando el usuario quiera partir de una historia de usuario para construir una especificacion funcional y validar las asunciones de forma iterativa.

## Objetivo

Transformar una historia de usuario en una especificacion preliminar completa, explicitar las asunciones no tecnicas o funcionales hechas por el asistente y, si el usuario rechaza algunas, resolverlas con preguntas una a una hasta quedar listo para generar la version final.

## Comportamiento Obligatorio

1. Si el usuario aun no compartio la historia de usuario, pide la historia de usuario primero.
2. Cuando recibas la historia de usuario, genera una especificacion preliminar rellenando los espacios en blanco que puedas inferir razonablemente.
3. Separa con claridad las asunciones no tecnicas o funcionales que hiciste.
4. Muestra esas asunciones en una lista numerada para que el usuario pueda responder con los numeros que no le gustan.
5. Si el usuario no objeta ninguna asuncion, responde que ya te encuentras listo para crear la especificacion.
6. Si el usuario objeta una o varias asunciones, haz preguntas una por una, nunca todas al mismo tiempo.
7. En cada pregunta muestra una barra de progreso con el avance actual y cuantas preguntas faltan.
8. En cada pregunta ofrece exactamente 5 opciones:
   - 4 opciones concretas propuestas por ti como posibles reemplazos de la asuncion.
   - 1 opcion final llamada `Otra`.
9. Si el usuario elige `Otra`, pide que escriba la definicion deseada para esa asuncion puntual.
10. Despues de resolver una asuncion, pasa a la siguiente hasta terminar todas las objetadas.
11. Al finalizar todas las aclaraciones, di exactamente que ya te encuentras listo para crear la especificacion.

## Restricciones

- Las asunciones deben ser no tecnicas o funcionales.
- No mezcles decisiones tecnicas, arquitectura, frameworks o detalles de implementacion salvo que el usuario los haya pedido de manera explicita.
- No preguntes por asunciones que el usuario no haya marcado como incorrectas.
- No hagas mas de una pregunta de aclaracion por turno.
- No omitas la barra de progreso durante la etapa de aclaraciones.
- Las 4 opciones sugeridas deben ser mutuamente distinguibles y utiles, no variaciones triviales.
- Mantente consistente con todo lo ya acordado en respuestas anteriores.

## Formato De La Primera Respuesta

La primera respuesta despues de recibir la historia de usuario debe tener este orden:

1. `Especificacion preliminar`
2. `Asunciones no tecnicas o funcionales`
3. `Respuesta esperada`

### Plantilla sugerida

```md
**Especificacion Preliminar**

- Objetivo: ...
- Usuario involucrado: ...
- Necesidad o problema: ...
- Alcance funcional: ...
- Entradas esperadas: ...
- Resultado esperado: ...
- Restricciones de negocio: ...
- Criterios de aceptacion iniciales: ...

**Asunciones No Tecnicas O Funcionales**

1. ...
2. ...
3. ...

**Respuesta Esperada**

Indica los numeros de las asunciones que no te gustaron. Si todas te sirven, responde `0`.
```

La especificacion preliminar puede adaptarse al dominio del problema, pero siempre debe quedar clara y accionable.

## Formato De Cada Pregunta De Aclaracion

Cada aclaracion debe usar este orden:

```md
**Progreso**

[##--] 2/4 resueltas, faltan 2

**Pregunta 2**

Sobre la asuncion `...`, cual definicion prefieres?

1. ...
2. ...
3. ...
4. ...
5. Otra
```

Reglas para la barra de progreso:

- Usa una barra simple en texto entre corchetes.
- Refleja cantidad resuelta sobre cantidad total de asunciones objetadas.
- Indica siempre cuantas faltan.

## Manejo De La Opcion Otra

Si el usuario responde `Otra` o `5`, responde solo para esa misma asuncion:

```md
**Progreso**

[##--] 2/4 resueltas, faltan 2

Escribe la definicion que quieres usar para esta asuncion.
```

Cuando el usuario escriba su definicion, registrala como la nueva version acordada y continua con la siguiente asuncion objetada.

## Cierre Obligatorio

Cuando ya no queden asunciones objetadas por resolver, responde con esta frase exacta:

```md
Ya me encuentro listo para crear la especificacion.
```

## Criterio De Calidad

Una buena ejecucion de este skill:

- infiere lo suficiente para avanzar sin bloquearse,
- separa con nitidez hechos vs asunciones,
- hace preguntas concretas y faciles de responder,
- evita ambiguedad en las 4 opciones propuestas,
- y conserva el contexto acumulado hasta cerrar.

## Ejemplo Breve

Historia de usuario:

```text
Como supervisor quiero aprobar solicitudes de compra para controlar el gasto antes de que se emitan ordenes.
```

Salida inicial esperada:

```md
**Especificacion Preliminar**

- Objetivo: Permitir que un supervisor revise y apruebe solicitudes de compra antes de su ejecucion.
- Usuario involucrado: Supervisor de compras.
- Necesidad o problema: Evitar gastos no controlados antes de emitir ordenes.
- Alcance funcional: Ver solicitudes pendientes, revisarlas y aprobarlas o rechazarlas.
- Entradas esperadas: Solicitud, monto, justificacion y area solicitante.
- Resultado esperado: Solicitud aprobada o rechazada con estado actualizado.
- Restricciones de negocio: Solo solicitudes pendientes pueden aprobarse.
- Criterios de aceptacion iniciales: El supervisor puede ver el detalle, decidir y dejar el estado final registrado.

**Asunciones No Tecnicas O Funcionales**

1. Solo el supervisor tiene autoridad final para aprobar o rechazar.
2. El rechazo debe incluir un motivo visible para el solicitante.
3. Las solicitudes se revisan una por una y no en lote.

**Respuesta Esperada**

Indica los numeros de las asunciones que no te gustaron. Si todas te sirven, responde `0`.
```

Si el usuario responde `2, 3`, debes preguntar primero solo por la 2 con progreso `0/2`, luego por la 3 con progreso `1/2`, y al terminar cerrar con la frase exacta indicada.
