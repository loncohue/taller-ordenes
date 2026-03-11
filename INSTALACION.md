# 🚀 Guía de instalación — Taller Gestión de Órdenes

## ✅ Las credenciales de Supabase YA ESTÁN configuradas en este proyecto.

---

## PASO 1 — Crear las tablas en Supabase

1. Entrá a https://supabase.com → iniciá sesión → abrí tu proyecto
2. En el menú izquierdo clickeá **SQL Editor**
3. Hacé click en **New Query**
4. Abrí el archivo `SUPABASE_SCHEMA.sql` de esta carpeta
5. Copiá TODO el contenido y pegalo en el editor
6. Hacé click en **Run** (botón verde) o presioná Ctrl+Enter
7. Debe aparecer "Success. No rows returned" → ¡listo!

---

## PASO 2 — Crear los usuarios del taller

1. En Supabase andá a **Authentication** → **Users** → **Add User** → **Create New User**
2. Creá un usuario por cada persona:
   - santiago@taller.com
   - rafael@taller.com
   - roque@taller.com
   - admin@taller.com
3. Para cada usuario, activá "Auto Confirm User" antes de crear

---

## PASO 3 — Subir el código a GitHub

1. Entrá a https://github.com → iniciá sesión
2. Click en **New** (repositorio nuevo)
3. Nombre: `taller-ordenes` → **Create Repository**
4. En el repo vacío, click en **"uploading an existing file"**
5. Descomprimí este ZIP y arrastrá TODOS los archivos y la carpeta `src`
6. Click en **Commit changes**

---

## PASO 4 — Publicar en Vercel

1. Entrá a https://vercel.com → iniciá sesión con GitHub
2. Click en **Add New Project** → importá `taller-ordenes`
3. En **Environment Variables** agregá:

   VITE_SUPABASE_URL
   https://hmzhhknjvnajispgnaie.supabase.co

   VITE_SUPABASE_ANON_KEY
   eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imhtemhoa25qdm5hamlzcGduYWllIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzMxMDEyMzcsImV4cCI6MjA4ODY3NzIzN30.GewuMGI0cA0Vxp14YxEoVFXJd1rlQubbEZfAinZVIPs

4. Click en **Deploy** → esperá 1-2 minutos → ¡tu URL está lista!

---

## ✅ Resultado final

URL pública tipo: https://taller-ordenes.vercel.app
- Login con email y contraseña
- Tiempo real entre todos los usuarios
- Funciona desde celular, tablet y PC

## 📱 Instalar en celular

- iPhone: Safari → compartir → "Agregar a pantalla de inicio"
- Android: Chrome → menú → "Agregar a pantalla de inicio"

## 🔧 Problemas comunes

- Pantalla en blanco → revisá variables de entorno en Vercel
- "Invalid login" → asegurate de haber creado usuarios con Auto Confirm
- Datos no guardan → verificá que el SQL se ejecutó sin errores
