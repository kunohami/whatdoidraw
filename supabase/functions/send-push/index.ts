import { serve } from "https://deno.land/std@0.192.0/http/server.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2"
import { JWT } from "npm:google-auth-library@9"

interface NotificationPayload {
  record: {
    id: string
    user_id: string
    actor_id: string
    type: string
    target_id: string
    created_at: string
  }
}

serve(async (req) => {
  try {
    // 1. Obtener el payload enviado por el Webhook de Supabase
    const payload: NotificationPayload = await req.json()
    console.log('Received notification payload:', payload)
    
    const { id, user_id, actor_id, type, target_id } = payload.record

    // 2. Inicializar cliente de Supabase usando Service Role Key para evadir políticas RLS
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // 3. Obtener token FCM y preferencias del receptor
    const { data: recipient, error: recipientError } = await supabaseClient
      .from('users')
      .select('fcm_token, push_notifications')
      .eq('id', user_id)
      .single()

    if (recipientError || !recipient) {
      console.error('Error fetching recipient:', recipientError)
      return new Response(JSON.stringify({ error: 'Recipient not found' }), { status: 404 })
    }

    // Verificar si tiene las notificaciones push activas y cuenta con un token
    if (!recipient.push_notifications || !recipient.fcm_token) {
      console.log('Push notifications disabled or no FCM token for user:', user_id)
      return new Response(JSON.stringify({ success: true, message: 'Skipped (Push disabled or no token)' }), {
        headers: { 'Content-Type': 'application/json' },
      })
    }

    // 4. Obtener el nombre del autor de la acción (actor_id)
    const { data: actor, error: actorError } = await supabaseClient
      .from('users')
      .select('username')
      .eq('id', actor_id)
      .single()

    if (actorError || !actor) {
      console.error('Error fetching actor:', actorError)
      return new Response(JSON.stringify({ error: 'Actor not found' }), { status: 404 })
    }

    // 5. Construir título y cuerpo del mensaje según el tipo de notificación
    let body = ''
    if (type === 'idea_used_for_doodle') {
      body = `@${actor.username} ha usado tu idea para un doodle`
    } else if (type === 'idea_used_for_artwork') {
      body = `@${actor.username} ha usado tu idea para un artwork`
    } else if (type === 'doodle_used_for_artwork') {
      body = `@${actor.username} ha usado tu doodle para un artwork`
    } else {
      body = `@${actor.username} interactuó con tu contenido`
    }

    // 6. Cargar el JSON de la cuenta de servicio de Firebase desde variables de entorno
    const serviceAccountJson = Deno.env.get('FIREBASE_SERVICE_ACCOUNT')
    if (!serviceAccountJson) {
      console.error('FIREBASE_SERVICE_ACCOUNT environment variable is not set!')
      return new Response(JSON.stringify({ error: 'Missing Firebase credentials' }), { status: 500 })
    }

    const serviceAccount = JSON.parse(serviceAccountJson)

    // 7. Generar Token OAuth2 de Google usando google-auth-library
    const jwtClient = new JWT({
      email: serviceAccount.client_email,
      key: serviceAccount.private_key,
      scopes: ['https://www.googleapis.com/auth/firebase.messaging'],
    })

    const credentials = await jwtClient.getAccessToken()
    const accessToken = credentials.token

    if (!accessToken) {
      throw new Error('Failed to obtain Google Access Token')
    }

    // 8. Enviar notificación push mediante la API HTTP v1 de FCM
    const projectId = serviceAccount.project_id
    const fcmUrl = `https://fcm.googleapis.com/v1/projects/${projectId}/messages:send`

    const response = await fetch(fcmUrl, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${accessToken}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        message: {
          token: recipient.fcm_token,
          notification: {
            title: 'whatdoidraw?',
            body: body,
          },
          data: {
            notification_id: id,
            type: type,
            target_id: target_id,
          },
          android: {
            notification: {
              click_action: 'FLUTTER_NOTIFICATION_CLICK',
              sound: 'default',
            },
          },
          apns: {
            payload: {
              aps: {
                sound: 'default',
              },
            },
          },
        },
      }),
    })

    const responseData = await response.json()
    console.log('FCM Send response:', responseData)

    return new Response(JSON.stringify({ success: true, response: responseData }), {
      headers: { 'Content-Type': 'application/json' },
    })
  } catch (error: any) {
    console.error('Error in send-push function:', error)
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    })
  }
})
