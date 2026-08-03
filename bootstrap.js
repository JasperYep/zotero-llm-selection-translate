var chromeHandle;

function install(data, reason) {}

async function startup({ resourceURI, rootURI }, reason) {
  await Zotero.initializationPromise;

  if (!rootURI) {
    rootURI = resourceURI.spec;
  }

  var aomStartup = Components.classes[
    "@mozilla.org/addons/addon-manager-startup;1"
  ].getService(Components.interfaces.amIAddonManagerStartup);
  var manifestURI = Services.io.newURI(rootURI + "manifest.json");
  chromeHandle = aomStartup.registerChrome(manifestURI, [
    ["content", "llmselectiontranslate", rootURI + "chrome/content/"],
  ]);

  const ctx = {
    rootURI,
  };
  ctx._globalThis = ctx;

  Services.scriptloader.loadSubScript(
    `${rootURI}/chrome/content/scripts/llmselectiontranslate.js`,
    ctx,
  );
}

async function onMainWindowLoad({ window }, reason) {
  Zotero.LLMSelectionTranslate?.hooks.onMainWindowLoad(window);
}

async function onMainWindowUnload({ window }, reason) {
  Zotero.LLMSelectionTranslate?.hooks.onMainWindowUnload(window);
}

function shutdown(data, reason) {
  if (reason === APP_SHUTDOWN) {
    return;
  }

  Zotero.LLMSelectionTranslate?.hooks.onShutdown();

  if (chromeHandle) {
    chromeHandle.destruct();
    chromeHandle = null;
  }
}

function uninstall(data, reason) {}
