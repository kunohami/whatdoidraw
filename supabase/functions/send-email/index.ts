import { serve } from "https://deno.land/std@0.192.0/http/server.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2"
import nodemailer from "npm:nodemailer"

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
    console.log('Received notification email payload:', payload)
    
    const { user_id, actor_id, type } = payload.record

    // 2. Inicializar cliente de Supabase usando Service Role Key
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // 3. Verificar si el receptor tiene activadas las notificaciones por correo
    const { data: recipient, error: recipientError } = await supabaseClient
      .from('users')
      .select('email_notifications')
      .eq('id', user_id)
      .single()

    if (recipientError || !recipient) {
      console.error('Error fetching recipient:', recipientError)
      return new Response(JSON.stringify({ error: 'Recipient not found' }), { status: 404 })
    }

    if (!recipient.email_notifications) {
      console.log('Email notifications disabled for user:', user_id)
      return new Response(JSON.stringify({ success: true, message: 'Skipped (Email disabled)' }), {
        headers: { 'Content-Type': 'application/json' },
      })
    }

    // 4. Obtener el correo electrónico real del receptor desde la tabla auth.users
    const { data: authUser, error: authUserError } = await supabaseClient.auth.admin.getUserById(user_id)
    if (authUserError || !authUser?.user?.email) {
      console.error('Error fetching recipient auth email:', authUserError)
      return new Response(JSON.stringify({ error: 'Recipient email not found' }), { status: 404 })
    }
    const email = authUser.user.email

    // 5. Obtener el nombre del autor de la acción (actor_id)
    const { data: actor, error: actorError } = await supabaseClient
      .from('users')
      .select('username')
      .eq('id', actor_id)
      .single()

    if (actorError || !actor) {
      console.error('Error fetching actor:', actorError)
      return new Response(JSON.stringify({ error: 'Actor not found' }), { status: 404 })
    }

    // 6. Construir el mensaje según el tipo de notificación
    let actionText = ''
    if (type === 'idea_used_for_doodle') {
      actionText = 'ha usado tu idea para un doodle'
    } else if (type === 'idea_used_for_artwork') {
      actionText = 'ha usado tu idea para un artwork'
    } else if (type === 'doodle_used_for_artwork') {
      actionText = 'ha usado tu doodle para un artwork'
    } else {
      actionText = 'interactuó con tu contenido'
    }

    const notificationMessage = `@${actor.username} ${actionText}`

    // 7. Cargar credenciales SMTP de Gmail desde variables de entorno
    const smtpUser = Deno.env.get('SMTP_USER')
    const smtpPass = Deno.env.get('SMTP_PASS')

    if (!smtpUser || !smtpPass) {
      console.error('SMTP_USER or SMTP_PASS environment variables are not set!')
      return new Response(JSON.stringify({ error: 'Missing SMTP credentials' }), { status: 500 })
    }

    // Plantilla HTML premium responsive adaptada a los colores oscuros/morados de la app
    const htmlContent = `
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>whatdoidraw?</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #0b071e;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      color: #ffffff;
      -webkit-font-smoothing: antialiased;
    }
    .wrapper {
      width: 100%;
      background-color: #0b071e;
      padding: 40px 0;
    }
    .container {
      max-width: 600px;
      margin: 0 auto;
      background: linear-gradient(145deg, #161035 0%, #0d0924 100%);
      border-radius: 16px;
      border: 1px solid #2d235c;
      overflow: hidden;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
    }
    .header {
      padding: 30px 20px;
      text-align: center;
      background: linear-gradient(to bottom, rgba(144, 97, 249, 0.15) 0%, rgba(0,0,0,0) 100%);
      border-bottom: 1px solid rgba(144, 97, 249, 0.1);
    }
    .logo {
      font-size: 26px;
      font-weight: 800;
      color: #9061f9;
      letter-spacing: -0.5px;
    }
    .content {
      padding: 40px 30px;
      text-align: center;
    }
    .title {
      font-size: 22px;
      font-weight: 700;
      margin-bottom: 16px;
      color: #ffffff;
    }
    .text {
      font-size: 16px;
      line-height: 1.6;
      color: #b9b6cd;
      margin-bottom: 32px;
    }
    .highlight {
      color: #9061f9;
      font-weight: 600;
    }
    .button-container {
      margin-bottom: 32px;
    }
    .button {
      display: inline-block;
      padding: 14px 32px;
      background: linear-gradient(135deg, #9061f9 0%, #703bf7 100%);
      color: #ffffff !important;
      text-decoration: none;
      font-weight: 700;
      border-radius: 12px;
      box-shadow: 0 4px 15px rgba(144, 97, 249, 0.3);
    }
    .footer {
      padding: 24px;
      text-align: center;
      background-color: rgba(0, 0, 0, 0.2);
      border-top: 1px solid rgba(144, 97, 249, 0.05);
      font-size: 12px;
      color: #635f80;
    }
    .footer a {
      color: #9061f9;
      text-decoration: none;
    }
  </style>
</head>
<body>
  <div class="wrapper">
    <div class="container">
      <div class="header">
        <div class="logo">whatdoidraw?</div>
      </div>
      <div class="content">
        <h1 class="title">¡Tu creación está inspirando a la comunidad!</h1>
        <p class="text">
          Hola,<br><br>
          Queremos contarte que alguien se ha inspirando en tu trabajo en la comunidad de <strong>whatdoidraw?</strong>.<br><br>
          <span class="highlight">${notificationMessage}</span>.
        </p>
        <div class="button-container">
          <span class="button" style="cursor: default;">¡Abre la App en tu móvil!</span>
        </div>
      </div>
      <div class="footer">
        <p>Has recibido este correo porque tienes activadas las notificaciones por correo en la aplicación <strong>whatdoidraw?</strong>.</p>
        <p style="margin-top: 10px; line-height: 1.5;">Puedes desactivar estas notificaciones en cualquier momento desde las opciones de la aplicación: ve a tu <strong>Perfil</strong>, toca el icono de <strong>engranaje (Ajustes)</strong> y desactiva <strong>Notificaciones por Correo</strong>.</p>
      </div>
    </div>
  </div>
</body>
</html>
    `

    // 8. Configurar transportador de nodemailer para Gmail SMTP
    const transporter = nodemailer.createTransport({
      host: "smtp.gmail.com",
      port: 465,
      secure: true, // TLS
      auth: {
        user: smtpUser,
        pass: smtpPass,
      },
    })

    // 9. Enviar el correo electrónico
    const info = await transporter.sendMail({
      from: `"whatdoidraw?" <${smtpUser}>`,
      to: email,
      subject: '¡Alguien se ha inspirado en tu contenido!',
      html: htmlContent,
    })

    console.log('Email sent successfully via Nodemailer/Gmail SMTP to:', email, 'MessageId:', info.messageId)

    return new Response(JSON.stringify({ success: true, message: 'Email sent successfully', messageId: info.messageId }), {
      headers: { 'Content-Type': 'application/json' },
    })
  } catch (error: any) {
    console.error('Error in send-email function:', error)
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    })
  }
})
