'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "56f53cacd1e13612bfd1db7b04680a72",
"assets/AssetManifest.bin.json": "284edf06f25490a368dc4d24e4c75737",
"assets/AssetManifest.json": "6f25ba2291422a4ee95e314515efb627",
"assets/assets/data/listings.txt": "54b23f174cf214a1cdcceab1b566d36a",
"assets/assets/fonts/Roboto-Black.ttf": "53ab4bb513d53af898e25637a2750ffc",
"assets/assets/fonts/Roboto-BlackItalic.ttf": "fc9c6dc66452de428b034f2af1a561ce",
"assets/assets/fonts/Roboto-Bold.ttf": "2e9b3d16308e1642bf8549d58c60f5c9",
"assets/assets/fonts/Roboto-BoldItalic.ttf": "fa726104cd4b7e8f106e391fea744b08",
"assets/assets/fonts/Roboto-Italic.ttf": "270c8dce1ab3c57848d7d278cb96574f",
"assets/assets/fonts/Roboto-Light.ttf": "5b55e48d4daee5634648dd487340e37e",
"assets/assets/fonts/Roboto-LightItalic.ttf": "b4591abf6ddac60905ad8a2ac5ba5363",
"assets/assets/fonts/Roboto-Medium.ttf": "6679d67d72e0e7b34f407bac6df715ab",
"assets/assets/fonts/Roboto-MediumItalic.ttf": "18191c4ed1413aac2700bbfa58b90774",
"assets/assets/fonts/Roboto-Regular.ttf": "327362a7c8d487ad3f7970cc8e2aba8d",
"assets/assets/fonts/Roboto-Thin.ttf": "8e1900eabb62e4e502ee3de329e0b833",
"assets/assets/fonts/Roboto-ThinItalic.ttf": "0d058ce1aecaa16d26b71bdab2be31b0",
"assets/assets/images/art/music.png": "33f137914a069db9591b4083fbfddc21",
"assets/assets/images/clothing.png": "12fb2a33de023ab78191b5ac857da6f9",
"assets/assets/images/furniture.png": "031c732c19614d10f3e10e9a667f7f7b",
"assets/assets/images/handiwork.png": "af9bc8f51d8056618233387b0d7dd474",
"assets/assets/images/nature.png": "0354e6ee677f3ef9e0072825ab5ac698",
"assets/assets/images/notes.png": "9d4b5a25961981af0340af705c7bdd28",
"assets/assets/images/other.png": "0acda48e276304277e0df91733c19dc1",
"assets/assets/images/talking/listening.png": "f7dd05021ce3ea993d24c619a5df390b",
"assets/assets/images/textbooks.png": "aa2a18184c4dcc67145094376ee43a85",
"assets/assets/images/tutoring.png": "04f8c990f2457ae54f9abdec8df55df8",
"assets/assets/items/person0-resized.png": "701c774ee1bee2d895b17077c0a594d2",
"assets/assets/items/person1-resized.png": "55786cd2b9e30dcd2f37dcbc78bca1c5",
"assets/assets/items/person10-resized.png": "3b303dc7d59e39b1db4a35383e7b86b0",
"assets/assets/items/person11-resized.png": "d662c56f60dcf261b08161951654cc68",
"assets/assets/items/person12-resized.png": "3748fcf1783ab1db8a22663c602e58b5",
"assets/assets/items/person13-resized.png": "05154d50779e67dbd2249f70804156f8",
"assets/assets/items/person14-resized.png": "8cfa7bcc4744b0a91f9f88c4505ac4c7",
"assets/assets/items/person15-resized.png": "5613d5727d9b58bcdaed23d926b5f5ce",
"assets/assets/items/person16-resized.png": "6ebd224e6e90efe87de9e88ecbd085de",
"assets/assets/items/person17-resized.png": "3bded87f7cfc5499d811545ed11048e5",
"assets/assets/items/person18-resized.png": "2e47b2eb055088b05a8c5bd71d56c655",
"assets/assets/items/person19-resized.png": "1919727dede4b3d595afca6507b08a08",
"assets/assets/items/person2-resized.png": "7907c90c2a3f05961f69ccede4232440",
"assets/assets/items/person3-resized.png": "7e649ed3f6ba413f715430cc0946f157",
"assets/assets/items/person4-resized.png": "de62f268a6014f5e199f46ed70c4e5be",
"assets/assets/items/person5-resized.png": "c89ed235f593f42ca9074d50749676f8",
"assets/assets/items/person6-resized.png": "54c8a26d8182dbcb8a14146ad70f3b04",
"assets/assets/items/person7-resized.png": "de6a4648924e5e0404f3b3e2b488ef7d",
"assets/assets/items/person8-resized.png": "d9d92fa6c8a8757b0e1940701db80dab",
"assets/assets/items/person9-resized.png": "89b12bf268fd2927ceb82c9d6969a5dd",
"assets/assets/logo.png": "aa08f5f6740fc61adef4a3f436c0e8c2",
"assets/assets/logored.png": "1d82519df86ef72e3cc9373ff9debc96",
"assets/assets/my_items/item0.png": "c1a0b50bdec15eac6cdfbe59d5c983b3",
"assets/assets/my_items/item1.png": "24efb7bad56c037f1ba28c6c95000e7d",
"assets/assets/sounds/button_click.mp3": "a4366f347c96ade2e5c43083346236f8",
"assets/assets/sounds/poland.mp3": "52a10937d66e9276989e20a2d327968d",
"assets/assets/sounds/swoosh.mp3": "a2d0f86f595125feeca18edfbf48025e",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "2ab5e775b0624bbcc8ed8d531d042c94",
"assets/NOTICES": "b9d73e42e4a80380177e833ee28ab5f9",
"assets/packages/flutter_map/lib/assets/flutter_map_logo.png": "208d63cc917af9713fc9572bd5c09362",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"flutter_bootstrap.js": "3303ffc881f7a25784a6090fb9d06e28",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "c275665a02ba88757415543d9f8cba1f",
"/": "c275665a02ba88757415543d9f8cba1f",
"main.dart.js": "9bfb3068e1be722d4ffa096104d47dd3",
"manifest.json": "5857aaa609cd2bfb3917394ec8dd96b5",
"version.json": "68f616ae49deda99e9864a522f982644"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
