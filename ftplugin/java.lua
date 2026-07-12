local jdtls = require("jdtls")

-- Get the jdtls install path from Mason
local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local config_path = jdtls_path .. "/config_mac_arm"
local plugins_path = jdtls_path .. "/plugins"
local lombok_path = jdtls_path .. "/lombok.jar"

-- Determine workspace directory
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/workspace/" .. project_name

-- Get capabilities from nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. lombok_path,
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", vim.fn.glob(plugins_path .. "/org.eclipse.equinox.launcher_*.jar"),
    "-configuration", config_path,
    "-data", workspace_dir,
  },
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
  capabilities = capabilities,
  settings = {
    java = {
      imports = {
        gradle = {
          wrapper = {
            checksums = {
              {
                sha256 = "497c8c2a7e5031f6aa847f88104aa80a93532ec32ee17bdb8d1d2f67a194a9c7",
                allowed = true,
              },
            },
          },
        },
      },
    },
  },
}

jdtls.start_or_attach(config)
