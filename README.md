Taiga Contrib Call To Action
============================

[![Kaleidos Project](http://kaleidos.net/static/img/badge.png)](https://github.com/kaleidos "Kaleidos Project")
[![Managed with Taiga.io](https://img.shields.io/badge/managed%20with-TAIGA.io-709f14.svg)](https://tree.taiga.io/project/taiga/ "Managed with Taiga.io")

The Taiga plugin project call to action.

Installation
------------
### Production env

#### Taiga Front

Download in your `dist/plugins/` directory of Taiga front the `taiga-contrib-call-to-action` compiled code (you need subversion in your system):

```bash
  cd dist/
  mkdir -p plugins
  cd plugins
  svn export "https://github.com/taigaio/taiga-contrib-call-to-action/branches/stable/dist"  "call-to-action"
```

Include in your `dist/conf.json` in `privacyPolicyUrl` the url to the information of your Privacy Policy and in the `contribPlugins` list the value `"/plugins/call-to-action/call-to-action.json"`:

```json
...
    "privacyPolicyUrl": "http://example.com/privacy-policy.html"
    "contribPlugins": [
        (...)
        "/plugins/call-to-action/call-to-action.json"
    ]
...
```

### Dev env

#### Taiga Front

After clone the repo link `dist` in `taiga-front` plugins directory:

```bash
  cd taiga-front/dist
  mkdir -p plugins
  cd plugins
  ln -s ../../../taiga-contrib-call-to-action/dist call-to-action
```

Include in your `dist/conf.json` in `privacyPolicyUrl` the url to the information of your Privacy Policy and in the `contribPlugins` list the value `"/plugins/call-to-action/call-to-action.json"`:

```json
...
    "privacyPolicyUrl": "http://example.com/privacy-policy.html"
    "contribPlugins": [
        (...)
        "/plugins/call-to-action/call-to-action.json"
    ]
...
```

In the plugin source dir `taiga-contrib-call-to-action` run

```bash
  npm install
```
and use:

- `gulp` to regenerate the source and watch for changes.
- `gulp build` to only regenerate the source.

