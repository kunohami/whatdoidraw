# Flujo de Trabajo con Git y GitHub

Para mantener el historial del proyecto limpio y fácil de seguir, hemos establecido una serie de convenciones y configuraciones obligatorias a la hora de trabajar con ramas y Pull Requests.

## 1. Configuración Local Recomendada

Para evitar los commits automáticos de *merge* que ensucian el historial al hacer un pull, se recomienda encarecidamente configurar tu Git local para que haga **rebase** por defecto.

Abre tu terminal y ejecuta:
```bash
git config --global pull.rebase true
```
*Si usas GitHub Desktop, esta configuración también será respetada.*

## 2. Reglas de Pull Requests (GitHub)

Nuestras Pull Requests en GitHub están configuradas para seguir unas políticas estrictas de fusión:

- **Squash and Merge:** No se permiten los clásicos *merge commits*. Todas las PRs deben ser fusionadas usando la opción *Squash and Merge*. Esto comprimirá todos los commits de tu rama de trabajo en **un único commit significativo** dentro de la rama principal (`main` o `master`).
- **Borrado Automático de Ramas:** Una vez que tu Pull Request es fusionada de forma exitosa, la rama en la nube será eliminada automáticamente para mantener limpio tanto tu entorno remoto como tu entorno de GitHub Desktop.

## 3. Mejores Prácticas al trabajar en Local

Si estás trabajando y notas que tu rama se quedó atrás de `main`:

- **Si usas terminal:** Haz `git pull origin main --rebase` en lugar de `git merge main`.
- **Si usas GitHub Desktop:** En el menú superior, ve a **Branch** > **Rebase current branch** (selecciona `main`) y luego fuerza el push si tu rama ya existía remotamente.

Además, si consideras que tus commits locales están muy ruidosos ("arreglo coma", "intento 2", etc.), puedes hacer un *Squash* locamente en GitHub Desktop (seleccionando todo en el History y dando a "Squash") o usando `git rebase -i` en tu terminal antes de crear la Pull Request.
