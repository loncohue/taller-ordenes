-- ================================================================
-- EJECUTAR ESTO EN SUPABASE > SQL Editor > New Query
-- ================================================================

-- 1. TABLA DE ÓRDENES
create table if not exists ordenes (
  id            bigserial primary key,
  orden         text not null,
  fecha         timestamptz not null default now(),
  asesor        text not null,
  mecanicos     text[] default '{}',
  servicio      text default 'ninguno',
  adicionales   text default '',
  otros         text default '',
  presupuesto   boolean default false,
  presupuesto_tipo    text default '',
  presupuesto_detalle text default '',
  respuesta_cliente   text default '',
  respuesta_fecha     timestamptz,
  estado        text default 'A la espera',
  lavado        boolean default false,
  terminado_en_dia boolean default false,
  finalizado_fecha    timestamptz,
  notas         text default '',
  created_at    timestamptz default now()
);

-- 2. TABLA DE NOTIFICACIONES
create table if not exists notificaciones (
  id         bigserial primary key,
  user_id    uuid references auth.users(id) on delete cascade,
  mensaje    text not null,
  leida      boolean default false,
  orden_id   bigint references ordenes(id) on delete set null,
  created_at timestamptz default now()
);

-- 3. HABILITAR REALTIME (para que los cambios se vean al instante en todos)
alter publication supabase_realtime add table ordenes;
alter publication supabase_realtime add table notificaciones;

-- 4. SEGURIDAD (Row Level Security)
alter table ordenes enable row level security;
alter table notificaciones enable row level security;

-- Cualquier usuario logueado puede ver y modificar órdenes
create policy "Usuarios autenticados pueden ver ordenes"
  on ordenes for select using (auth.role() = 'authenticated');

create policy "Usuarios autenticados pueden crear ordenes"
  on ordenes for insert with check (auth.role() = 'authenticated');

create policy "Usuarios autenticados pueden editar ordenes"
  on ordenes for update using (auth.role() = 'authenticated');

-- Cada usuario solo ve sus propias notificaciones
create policy "Ver propias notificaciones"
  on notificaciones for select using (auth.uid() = user_id);

create policy "Actualizar propias notificaciones"
  on notificaciones for update using (auth.uid() = user_id);

-- ================================================================
-- FUNCIÓN: Crear notificación cuando cambia el estado de una orden
-- ================================================================
create or replace function notificar_cambio_estado()
returns trigger as $$
begin
  if old.estado is distinct from new.estado then
    insert into notificaciones (user_id, mensaje, orden_id)
    select id, 
      'Orden #' || new.orden || ' cambió a: ' || new.estado,
      new.id
    from auth.users;
  end if;
  return new;
end;
$$ language plpgsql security definer;

create trigger on_estado_cambia
  after update on ordenes
  for each row execute procedure notificar_cambio_estado();

-- ================================================================
-- CREAR USUARIOS (hacer esto en Authentication > Users > Add User)
-- Usuarios sugeridos:
--   santiago@taller.com   (contraseña a elección)
--   rafael@taller.com
--   roque@taller.com
--   admin@taller.com
-- ================================================================
