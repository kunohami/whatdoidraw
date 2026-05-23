-- IMPORTANTE: Borramos las notificaciones antiguas porque el formato ha cambiado. 
-- Si no lo hacemos primero, PostgreSQL dará error al intentar aplicar la nueva regla.
DELETE FROM notifications;

-- 1. Actualizar el constraint de la tabla (solo en la base de datos)
ALTER TABLE notifications DROP CONSTRAINT IF EXISTS notifications_type_check;
ALTER TABLE notifications ADD CONSTRAINT notifications_type_check CHECK (type IN ('idea_used_for_doodle', 'idea_used_for_artwork', 'doodle_used_for_artwork'));

-- 2. Actualizar Función Trigger para Doodles
CREATE OR REPLACE FUNCTION notify_idea_used_on_doodle()
RETURNS TRIGGER AS $$
DECLARE
  v_idea_owner UUID;
BEGIN
  IF NEW.idea_id IS NOT NULL THEN
    SELECT user_id INTO v_idea_owner FROM ideas WHERE id = NEW.idea_id;
    IF v_idea_owner IS NOT NULL AND v_idea_owner != NEW.user_id THEN
      INSERT INTO notifications (user_id, actor_id, type, target_id)
      VALUES (v_idea_owner, NEW.user_id, 'idea_used_for_doodle', NEW.id);
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. Actualizar Función Trigger para Artworks
CREATE OR REPLACE FUNCTION notify_used_on_artwork()
RETURNS TRIGGER AS $$
DECLARE
  v_owner UUID;
BEGIN
  IF NEW.doodle_id IS NOT NULL THEN
    SELECT user_id INTO v_owner FROM doodles WHERE id = NEW.doodle_id;
    IF v_owner IS NOT NULL AND v_owner != NEW.user_id THEN
      INSERT INTO notifications (user_id, actor_id, type, target_id)
      VALUES (v_owner, NEW.user_id, 'doodle_used_for_artwork', NEW.id);
    END IF;
  ELSIF NEW.idea_id IS NOT NULL THEN
    SELECT user_id INTO v_owner FROM ideas WHERE id = NEW.idea_id;
    IF v_owner IS NOT NULL AND v_owner != NEW.user_id THEN
      INSERT INTO notifications (user_id, actor_id, type, target_id)
      VALUES (v_owner, NEW.user_id, 'idea_used_for_artwork', NEW.id);
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- IMPORTANTE: Para probar de nuevo, borra la notificación antigua o su `type` será inválido
DELETE FROM notifications;
