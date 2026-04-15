# Flujo de Trabajo con Git y GitHub

Para mantener el historial del proyecto limpio y fácil de seguir, se ha establecido una serie de convenciones y configuraciones obligatorias a la hora de trabajar con ramas y Pull Requests.

## 1. Configuración Local Recomendada

Para evitar los commits automáticos de *merge* que ensucian el historial al hacer un pull, se recomienda encarecidamente configurar el Git local para que haga **rebase** por defecto.

Abre la terminal y ejecuta:
```bash
git config --global pull.rebase true
```
*Si se usa GitHub Desktop, esta configuración también será respetada.*

## 2. Reglas de Pull Requests (GitHub)

Las Pull Requests en GitHub están configuradas para seguir unas políticas estrictas de fusión:

- **Squash and Merge:** No se permiten los clásicos *merge commits*. Todas las PRs deben ser fusionadas usando la opción *Squash and Merge*. Esto comprimirá todos los commits de la rama de trabajo en **un único commit significativo** dentro de la rama principal (`main` o `master`).
- **Borrado Automático de Ramas:** Una vez que la Pull Request es fusionada de forma exitosa, la rama en la nube será eliminada automáticamente para mantener limpio tanto el entorno remoto como el entorno de GitHub Desktop.

## 3. Mejores Prácticas al trabajar en Local

Si se está trabajando y se nota que la rama se quedó atrás de `main`:

- **Si se usa terminal:** Hacer `git pull origin main --rebase` en lugar de `git merge main`.
- **Si se usa GitHub Desktop:** En el menú superior, ir a **Branch** > **Rebase current branch** (selecciona `main`) y luego forzar el push si la rama ya existía remotamente.

Además, si se considera que los commits locales están muy ruidosos ("arreglo coma", "intento 2", etc.), se puede hacer un *Squash* locamente en GitHub Desktop (seleccionando todo en el History y dando a "Squash") o usando `git rebase -i` en la terminal antes de crear la Pull Request.

## 4. Integración Continua (CI) y Protección de Ramas

El proyecto cuenta con un *workflow* automatizado a través de **GitHub Actions** (`.github/workflows/flutter_ci.yml`). Cada vez que se abre una Pull Request hacia `main`, un robot ejecutará una serie de comprobaciones necesarias:

- **Instala las dependencias y prepara el entorno.**
- **Revisa el formato y el Linter (`flutter analyze`):** Detecta variables sin usar, código "sucio" y violaciones de convenciones.
- **Ejecuta las pruebas (`flutter test`):** Asegura que no se rompa nada previamente implementado.
- **Valida la compilación (`flutter build apk`):** Confirma que el proyecto puede construirse exitosamente.

### Fusión (Merge) Responsable

> **Importante para repositorios privados:** Debido a limitaciones del plan gratuito de GitHub en repositorios privados, resulta imposible forzar un bloqueo técnico en el botón de Merge para requerir que pasen los análisis.

Por norma estricta del proyecto, los desarrolladores deben **auto-regularse** de la siguiente manera:
1. Al crear una PR, **se debe esperar a que termine el proceso** de integración (aproximadamente 2 - 4 minutos).
2. Si el proceso arroja aspas rojas (❌), **ESTÁ TOTALMENTE PROHIBIDO OPRIMIR EL BOTÓN DE "MERGE"**. Se deben solucionar los errores localmente y actualizar la rama.
3. El Squash and Merge se permite de forma exclusiva, sin excepción, ante la total presencia de las comprobaciones exitosas y marcas verdes (✅).
