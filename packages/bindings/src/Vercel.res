@val @scope(("process", "env"))
external url: string = "VERCEL_URL"
@val @scope(("process", "env"))
external projectProductionUrl: string = "VERCEL_PROJECT_PRODUCTION_URL"
@val @scope(("process", "env"))
external projectBranchUrl: string = "VERCEL_BRANCH_URL"

type env = | @as("production") Production | @as("development") Development | @as("preview") Preview
@val @scope(("process", "env"))
external env: option<env> = "VERCEL_ENV"

module Vite = {
  @val @scope(("import", "meta", "env"))
  external url: string = "VITE_VERCEL_URL"
  @val @scope(("import", "meta", "env"))
  external projectProductionUrl: string = "VITE_VERCEL_PROJECT_PRODUCTION_URL"
  @val @scope(("import", "meta", "env"))
  external projectBranchUrl: string = "VITE_VERCEL_BRANCH_URL"

  type env =
    | @as("production") Production | @as("development") Development | @as("preview") Preview
  @val @scope(("import", "meta", "env"))
  external env: option<env> = "VITE_VERCEL_ENV"
}
