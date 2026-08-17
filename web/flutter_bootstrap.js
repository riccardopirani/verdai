{{flutter_js}}
{{flutter_build_config}}

const host = document.querySelector('#flutter-host');

window.addEventListener('flutter-first-frame', () => {
  host.removeAttribute('aria-hidden');
  document.documentElement.classList.add('flutter-ready');
});

_flutter.loader.load({
  config: {
    hostElement: host,
  },
});
