NixOS Options
────────────────────
# services.homepage-dashboard.customCSS
Custom CSS for styling Homepage.

See https://gethomepage.dev/latest/configs/custom-css-js/.

type: strings concatenated with "\n"


NixOS Options
────────────────────
# services.homepage-dashboard.enable
Whether to enable Homepage Dashboard, a highly customizable application dashboard.
type: boolean


NixOS Options
────────────────────
# services.homepage-dashboard.package
The homepage-dashboard package to use.
type: package


NixOS Options
────────────────────
# services.homepage-dashboard.kubernetes
Homepage kubernetes configuration.

See https://gethomepage.dev/latest/configs/kubernetes/.

type: YAML value


NixOS Options
────────────────────
# services.homepage-dashboard.bookmarks
Homepage bookmarks configuration.

See https://gethomepage.dev/latest/configs/bookmarks/.

type: YAML value


NixOS Options
────────────────────
# services.homepage-dashboard.environmentFile
The path to an environment file that contains environment variables to pass
to the homepage-dashboard service, for the purpose of passing secrets to
the service.

See the upstream documentation:

https://gethomepage.dev/latest/installation/docker/#using-environment-secrets

type: string


NixOS Options
────────────────────
# services.homepage-dashboard.services
Homepage services configuration.

See https://gethomepage.dev/latest/configs/services/.

type: YAML value


NixOS Options
────────────────────
# services.homepage-dashboard.customJS
Custom Javascript for Homepage.

See https://gethomepage.dev/latest/configs/custom-css-js/.

type: strings concatenated with "\n"


NixOS Options
────────────────────
# services.homepage-dashboard.widgets
Homepage widgets configuration.

See https://gethomepage.dev/latest/configs/service-widgets/.

type: YAML value


NixOS Options
────────────────────
# services.homepage-dashboard.listenPort
Port for Homepage to bind to.
type: signed integer


NixOS Options
────────────────────
# services.homepage-dashboard.settings
Homepage settings.

See https://gethomepage.dev/latest/configs/settings/.

type: YAML value


NixOS Options
────────────────────
# services.homepage-dashboard.openFirewall
Open ports in the firewall for Homepage.
type: boolean


NixOS Options
────────────────────
# services.homepage-dashboard.docker
Homepage docker configuration.

See https://gethomepage.dev/latest/configs/docker/.

type: YAML value


