//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <web_renderer/web_renderer_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) web_renderer_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "WebRendererPlugin");
  web_renderer_plugin_register_with_registrar(web_renderer_registrar);
}
