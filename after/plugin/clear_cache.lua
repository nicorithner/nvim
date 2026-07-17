-- Force clear package cache on startup for patched plugins
package.loaded['lualine.components.lsp_status'] = nil
