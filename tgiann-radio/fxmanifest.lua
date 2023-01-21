fx_version 'bodacious'
game 'gta5'

lua54 'yes'

escrow_ignore {
  'config.lua',
  'client/editable.lua',
  'server/editable.lua',
}

shared_script 'function.lua'

client_script {
  'config.lua',
  'client/*.lua',
}

server_script {
  'config.lua',
  'server/*.lua',
}

ui_page 'html/ui.html'

files {
  'html/ui.html',
  'html/js/*.js',
  'html/css/*.css',
  'html/img/*.png',
  'html/font/digital7-1e1z-webfont.woff',
  'html/font/digital7-1e1z-webfont.woff2',
}

dependencies {
  "baseevents"
}
dependency '/assetpacks'