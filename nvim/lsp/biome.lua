---@type vim.lsp.Config
return {
  cmd = { 'biome', 'lsp-proxy' },
  filetypes = {
    'astro',
    'css',
    'graphql',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'jsonc',
    'svelte',
    'typescript',
    'typescriptreact',
    'vue',
  },
  workspace_required = true,
  root_markers = {
    {
      'package-lock.json',
      'yarn.lock',
      'pnpm-lock.yaml',
      'bun.lockb',
      'bun.lock',
      'deno.lock',
    },
    { '.git' },
  },
  -- TODO: track https://github.com/biomejs/biome/pull/9392
  -- settings = { config_path = '/home/fisher/.config/biome/biome.jsonc' },
}
