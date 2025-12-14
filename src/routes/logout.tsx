import { APIError } from 'better-auth'
import { redirect, createFileRoute } from '@tanstack/react-router'
import { createServerFn } from '@tanstack/react-start'
import { auth } from '~/server/auth'

const logoutFn = createServerFn().handler(async ({ request }) => {
  try {
    await auth.api.signOut({
      headers: request.headers,
    })
  } catch (error) {
    if (!(error instanceof APIError)) {
      throw error
    }
  }

  throw redirect({
    href: '/',
  })
})

export const Route = createFileRoute('/logout')({
  preload: false,
  loader: () => logoutFn(),
})
