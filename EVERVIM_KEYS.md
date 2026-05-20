# EverVim — Atajos de Teclado

> Mac: `Cmd` = `⌘` · Windows/Linux: usar `Ctrl` equivalente  
> `leader` = `Space`

---

## Navegación

| Acción | Mac | Win/Lin |
|--------|-----|---------|
| Bajar 30 líneas (suave) | `Cmd+J` | `Ctrl+J` |
| Subir 30 líneas (suave) | `Cmd+K` | `Ctrl+K` |

---

## Archivos y Búsqueda (Telescope)

| Acción | Mac | Win/Lin |
|--------|-----|---------|
| Buscar archivo (≥2 chars) | `Cmd+P` | `Ctrl+P` |
| Buscar en proyecto (grep) | `Cmd+Shift+F` | `Ctrl+Shift+F` |
| Buscar en archivo actual | `Cmd+F` | `Ctrl+F` |
| Paleta de comandos | `Cmd+Shift+P` | `Ctrl+Shift+P` |

---

## Edición

| Acción | Mac | Win/Lin |
|--------|-----|---------|
| Guardar (sin formato) | `Cmd+S` | `Ctrl+S` |
| Guardar con formato (LSP/Prettier) | `Cmd+Shift+S` | `Ctrl+Shift+S` |
| Deshacer | `Cmd+Z` | `Ctrl+Z` |
| Rehacer | `Cmd+Shift+Z` | `Ctrl+Y` |
| Comentar / Descomentar | `Cmd+/` | `Ctrl+/` |
| Copiar línea / selección | `Cmd+C` | `Ctrl+C` |
| Pegar desde clipboard del sistema | `Cmd+V` | `Ctrl+V` |

---

## Pestañas y Paneles

| Acción | Mac | Win/Lin |
|--------|-----|---------|
| Cerrar buffer/pestaña | `Cmd+W` | `Ctrl+W` |
| Cerrar split (sin cerrar buffer) | `Cmd+Option+W` | `Ctrl+Alt+W` |
| Pestaña anterior | `Shift+Option+H` | — |
| Pestaña siguiente | `Shift+Option+L` | — |
| Ir a ventana izquierda | `Cmd+Shift+H` | `Ctrl+Shift+H` |
| Ir a ventana derecha | `Cmd+Shift+L` | `Ctrl+Shift+L` |
| Ir a ventana abajo | `Cmd+Shift+J` | — |
| Ir a ventana arriba | `Cmd+Shift+K` | — |
| Salir de todo | `Cmd+Q` | `Ctrl+Q` |

---

## Explorador y Terminal

| Acción | Mac | Win/Lin |
|--------|-----|---------|
| Toggle explorador de archivos | `Cmd+M` | `Ctrl+M` |
| Toggle terminal flotante | `Cmd+N` | `Ctrl+N` |

---

## Git

| Acción | Atajo |
|--------|-------|
| LazyGit (interfaz completa) | `leader+g+g` |
| Git blame del commit en línea actual | `g+t` (split inferior, `q` cierra) |
| Historial del archivo con diff | `Ctrl+,` (toggle) |
| Buscar conflictos de merge | `leader+f+c` |
| Resolver conflicto → nuestro | `leader+c+o` |
| Resolver conflicto → entrante | `leader+c+t` |
| Resolver conflicto → ambos | `leader+c+b` |
| Resolver conflicto → ninguno | `leader+c+0` |
| Siguiente conflicto | `]c` |
| Conflicto anterior | `[c` |

---

## Diagnósticos y TODOs

| Acción | Atajo |
|--------|-------|
| Panel de errores del proyecto (Trouble) | `leader+x+x` |
| Panel de errores del buffer actual | `leader+x+w` |
| Buscar TODOs / FIXMEs | `leader+f+t` |

---

## Temas

| Acción | Atajo |
|--------|-------|
| Theme picker (preview en vivo) | `leader+t+h` |

Navega con `j/k`, `Enter` guarda. Temas recomendados: `carbonfox` · `default-dark` · `decay` · `midnight_breeze` · `onedark` · `pastelbeans` · `rxyhn` · `yoru`

---

## Autocompletado (cmp)

| Acción | Tecla |
|--------|-------|
| Navegar sugerencias | `↑` / `↓` |
| Confirmar sugerencia | `Enter` |
| Cancelar | `Esc` |
