# 📝 Hoja de Evaluación: Miguel Espinal

**Evaluador:** Alan Gael Silis Ambrosio  
**Fecha de evaluación:** 25/10/2026

## 🚥 Código de Estado
* ⚪ **Blanco:** No probado aún.
* 🟡 **Amarillo:** Probado, pero se encontraron errores o detalles.
* 🟢 **Verde:** Probado y funciona perfectamente.

## 📊 Tabla de Pruebas

| Funcionalidad | Estado (⚪/🟡/🟢) | Observaciones / Errores Encontrados |
| :--- | :---: | :--- |
| Registro manual (Correo y Contraseña) | 🟢 | La cuenta si se pudo crear correctamente de forma manual, respeta los formatos de validación de campos. |
| Inicio de sesión manual | 🟡 | Al momento de acceder a la app con las credenciales que creé, me dice que es incorrecto y no me permite entrar a la aplicación. |
| Acceso con cuenta de Google | 🟢 | Si se pudo acceder correctamente con Google y pude visualizar el perfil. |
| Subir productos al inventario | ⚪ | No encontré ese apartado. |
| Realizar ventas | 🟢 | Al momento de comprar un producto, aparece la descripción y se pudo registrar la venta en la sección de mis pedidos. |
| Ver historial de ventas | 🟢 | Pude ver mi historial de compras que he realizado. |
| Agendar citas | ⚪ | No encontré ese apartado. |

## 💬 Reporte de Errores y Comentarios Adicionales
*(Si marcaste algo en amarillo 🟡, por favor describe el error con más detalle aquí. ¿Qué intentaste hacer y qué falló?)*

- **Error en Inicio de Sesión Manual (🟡):**
  - **Pasos:** 
    1. Se realizó con éxito el registro manual introduciendo un correo y contraseña válidos.
    2. Se procedió a la pantalla de Inicio de Sesión e intenté ingresar con las mismas credenciales que acabo de registrar.
  - **Comportamiento esperado:** La aplicación debería validar las credenciales y redirigir al menú principal o perfil.
  - **Comportamiento observado:** La aplicación devuelve un mensaje indicando que los datos son incorrectos, bloqueando el acceso al usuario.

- **Apartados no localizados (⚪):**
  - No se encontraron dentro de la navegación de la aplicación las funciones correspondientes a **Subir productos al inventario** ni **Agendar citas**. Se requiere confirmar si aún están en desarrollo o si se encuentran en una ruta distinta dentro de la interfaz.
