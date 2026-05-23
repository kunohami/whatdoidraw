-- Función Trigger para crear notificación al subir un nuevo Doodle
CREATE OR REPLACE FUNCTION notify_idea_used_on_doodle()
RETURNS TRIGGER AS $$
DECLARE
  v_idea_owner UUID;
BEGIN
  -- Si el doodle está basado en una idea
  IF NEW.idea_id IS NOT NULL THEN
    -- Obtener el dueño de la idea
    SELECT user_id INTO v_idea_owner FROM ideas WHERE id = NEW.idea_id;
    
    -- Solo notificar si el que crea el doodle NO es el dueño de la idea (no autolikes)
    IF v_idea_owner IS NOT NULL AND v_idea_owner != NEW.user_id THEN
      INSERT INTO notifications (user_id, actor_id, type, target_id)
      VALUES (v_idea_owner, NEW.user_id, 'idea_used', NEW.id);
    END IF;
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función Trigger para crear notificación al subir un nuevo Artwork
CREATE OR REPLACE FUNCTION notify_used_on_artwork()
RETURNS TRIGGER AS $$
DECLARE
  v_owner UUID;
BEGIN
  -- 1. Si está basado en un doodle, notificamos al creador del doodle
  IF NEW.doodle_id IS NOT NULL THEN
    SELECT user_id INTO v_owner FROM doodles WHERE id = NEW.doodle_id;
    IF v_owner IS NOT NULL AND v_owner != NEW.user_id THEN
      INSERT INTO notifications (user_id, actor_id, type, target_id)
      VALUES (v_owner, NEW.user_id, 'doodle_used', NEW.id);
    END IF;
    
  -- 2. Si no es de un doodle, pero sí de una idea directamente, notificamos al creador de la idea
  ELSIF NEW.idea_id IS NOT NULL THEN
    SELECT user_id INTO v_owner FROM ideas WHERE id = NEW.idea_id;
    IF v_owner IS NOT NULL AND v_owner != NEW.user_id THEN
      INSERT INTO notifications (user_id, actor_id, type, target_id)
      VALUES (v_owner, NEW.user_id, 'idea_used', NEW.id);
    END IF;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Crear los Triggers
DROP TRIGGER IF EXISTS on_doodle_created_notify ON doodles;
CREATE TRIGGER on_doodle_created_notify
  AFTER INSERT ON doodles
  FOR EACH ROW EXECUTE FUNCTION notify_idea_used_on_doodle();

DROP TRIGGER IF EXISTS on_artwork_created_notify ON artworks;
CREATE TRIGGER on_artwork_created_notify
  AFTER INSERT ON artworks
  FOR EACH ROW EXECUTE FUNCTION notify_used_on_artwork();
