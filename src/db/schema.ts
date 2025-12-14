import { pgTable, text } from 'drizzle-orm/pg-core'

export const users = pgTable('User', {
  email: text('email').primaryKey(),
  password: text('password').notNull(),
})
