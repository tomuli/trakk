import { APIError } from 'better-auth'
import { createFileRoute } from '@tanstack/react-router'
import { createServerFn } from '@tanstack/react-start'
import { Login } from '~/components/Login'
import { auth } from '~/server/auth'

export const loginFn = createServerFn({ method: 'POST' })
  .inputValidator(
    (d: { email: string; password: string; redirectUrl?: string }) => d,
  )
  .handler(async ({ data, request }) => {
    try {
      await auth.api.signInEmail({
        headers: request.headers,
        body: {
          email: data.email,
          password: data.password,
          callbackURL: data.redirectUrl,
          rememberMe: true,
        },
      })
      return
    } catch (error) {
      if (error instanceof APIError) {
        return {
          error: true,
          message: error?.body?.message || 'Unable to sign in',
        }
      }
      throw error
    }
  })

export const Route = createFileRoute('/_authed')({
  beforeLoad: ({ context }) => {
    if (!context.user) {
      throw new Error('Not authenticated')
    }
  },
  errorComponent: ({ error }) => {
    if (error.message === 'Not authenticated') {
      return <Login />
    }

    throw error
  },
})
