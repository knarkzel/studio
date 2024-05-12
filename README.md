# studio

To run it locally with Nix, do following:

```
RELEASE_TMP=/tmp RELEASE_COOKIE=my-cookie DATABASE_URL=postgres://postgres:postgres@localhost/studio_dev SECRET_KEY_BASE=DwdeOT9NnjAf5k2gNnQ8VkEEe5PIQm+ujFWhW+uq0u3EeHGSi4cVSMQbLFJo8vpa nix run .#default -- start
```

## Notes

I had to do following when running a Phoenix LiveView application in Nix:

- Run `mix2nix > deps.nix`
- Modify `config/prod.exs` with following: `config :studio, StudioWeb.Endpoint, http: [:inet6, port: 4000], server: true`
- Modify `config/config.exs` and add `path: System.get_env("MIX_ESBUILD_PATH")` for `:esbuild` and `path: System.get_env("MIX_TAILWIND_PATH")` for `:tailwind`. Because Mix tries to download TailwindCSS and Esbuild from GitHub, we have to specify these custom binaries via Nix and environment variables
- I had to get rid of heroicons in `tailwind.config.js`, had some issues I didn't figure out with that one
- When running, you need to define `RELEASE_TMP`, `RELEASE_COOKIE`, `DATABASE_URL` and `SECRET_KEY_BASE`
